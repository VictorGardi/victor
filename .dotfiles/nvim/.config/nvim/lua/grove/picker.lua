-- grove/picker.lua
-- Telescope picker for grove: task list, markdown preview, and function mode.

local M = {}

-- Module-level toggle state for showing done tasks
local show_done = false

-- ---------------------------------------------------------------------------
-- Helpers
-- ---------------------------------------------------------------------------

---Compute column widths from a list of tasks for aligned display.
---@param tasks table[]
---@return { id: number, title: number, repo: number }
local function compute_widths(tasks)
  local w = { id = 5, title = 20, repo = 10 }
  for _, t in ipairs(tasks) do
    w.id    = math.max(w.id,    #t.id)
    w.title = math.max(w.title, #t.title)
    w.repo  = math.max(w.repo,  #t.repo)
  end
  return w
end

---Build a display string for a single task using pre-computed widths.
---@param task  table
---@param widths { id: number, title: number, repo: number }
---@return string
local function format_entry(task, widths)
  return string.format(
    "%-" .. widths.id    .. "s  %-" .. widths.title .. "s  %s · %s",
    task.id,
    task.title,
    task.repo,
    task.status
  )
end

-- ---------------------------------------------------------------------------
-- Previewer
-- ---------------------------------------------------------------------------

---Create a Telescope buffer previewer that renders task markdown.
---Attempts render-markdown.nvim; falls back to treesitter syntax highlight.
---@return table  Telescope previewer
local function make_previewer()
  local previewers = require("telescope.previewers")

  return previewers.new_buffer_previewer({
    title = "Task",
    define_preview = function(self, entry)
      local bufnr = self.state.bufnr
      if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end

      local task = entry.value
      if not task or not task.path then
        return
      end

      -- Read the file content
      local ok, lines = pcall(vim.fn.readfile, task.path)
      if not ok then
        lines = { "-- could not read file --" }
      end

      -- Load content (preview buffers start as nomodifiable)
      vim.bo[bufnr].modifiable = true
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
      vim.bo[bufnr].filetype = "markdown"

      -- Activate render-markdown explicitly.
      -- render-markdown guards against buftype="nofile", so we temporarily
      -- clear it, call enable() in the buffer's context, then restore.
      vim.schedule(function()
        if not vim.api.nvim_buf_is_valid(bufnr) then return end

        local saved_bt = vim.bo[bufnr].buftype
        if saved_bt ~= "" then
          pcall(function() vim.bo[bufnr].buftype = "" end)
        end

        vim.api.nvim_buf_call(bufnr, function()
          pcall(function() require("render-markdown").enable() end)
        end)

        if saved_bt ~= "" then
          pcall(function() vim.bo[bufnr].buftype = saved_bt end)
        end
      end)
    end,
  })
end

-- ---------------------------------------------------------------------------
-- Function picker (triggered by "/")
-- ---------------------------------------------------------------------------

---Open the grove function picker.
---Currently supports one function: "add" (create a new task).
---@param git_dir string
function M.open_function_picker(git_dir)
  local pickers  = require("telescope.pickers")
  local finders  = require("telescope.finders")
  local conf     = require("telescope.config").values
  local actions  = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local functions = {
    { name = "add", desc = "Create a new task" },
  }

  pickers.new({}, {
    prompt_title = "grove · functions",
    finder = finders.new_table({
      results = functions,
      entry_maker = function(fn)
        return {
          value   = fn,
          display = string.format("%-10s  %s", fn.name, fn.desc),
          ordinal = fn.name,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if not selection then return end

        if selection.value.name == "add" then
          M._run_add_flow(git_dir)
        end
      end)
      return true
    end,
  }):find()
end

-- ---------------------------------------------------------------------------
-- Add flow (called after "add" is selected from function picker)
-- ---------------------------------------------------------------------------

---Run the full task-creation flow: name → repo → agent → create → jump.
---@param git_dir string
function M._run_add_flow(git_dir)
  local tasks_mod   = require("grove.tasks")
  local template    = require("grove.template")
  local tmux        = require("grove.tmux")

  -- Step 1: get task name
  vim.ui.input({ prompt = "grove · task name: " }, function(title)
    if not title or title == "" then return end

    -- Step 2: choose repo (all git repos, grove will bootstrap .tasks/ if needed)
    local repos = tasks_mod.scan_repos(git_dir)
    if #repos == 0 then
      vim.notify("grove: no git repos found under " .. git_dir, vim.log.levels.WARN)
      return
    end

    local repo_names = vim.tbl_map(function(r) return r.name end, repos)

    vim.ui.select(repo_names, { prompt = "grove · select repo: " }, function(repo_name)
      if not repo_name then return end

      -- Find the repo object
      local repo
      for _, r in ipairs(repos) do
        if r.name == repo_name then
          repo = r
          break
        end
      end
      if not repo then return end

      -- Step 3: choose agent
      vim.ui.select(
        { "opencode", "claude" },
        { prompt = "grove · choose agent: " },
        function(agent)
          if not agent then return end

          -- Step 4: create the task file
          local ok, task = pcall(template.create, repo.path, repo.name, title)
          if not ok then
            vim.notify("grove: failed to create task — " .. tostring(task), vim.log.levels.ERROR)
            return
          end

          vim.notify(
            string.format("grove: created %s in %s", task.id, repo.name),
            vim.log.levels.INFO
          )

          -- Step 5: jump to task (create session, send agent, switch)
          tmux.jump_to_task(task, agent)
        end
      )
    end)
  end)
end

-- ---------------------------------------------------------------------------
-- Main picker
-- ---------------------------------------------------------------------------

---Open the main grove task picker.
---@param all_tasks table[]  full unfiltered task list
function M.open(all_tasks)
  local pickers      = require("telescope.pickers")
  local finders      = require("telescope.finders")
  local conf         = require("telescope.config").values
  local actions      = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local config       = require("grove.config")
  local tmux         = require("grove.tmux")

  local git_dir = config.get().git_dir

  -- Filter out done tasks unless show_done is toggled
  local tasks = vim.tbl_filter(function(t)
    return show_done or t.status ~= "done"
  end, all_tasks)

  local widths = compute_widths(tasks)

  local title_suffix = show_done and " [all]" or ""

  pickers.new({}, {
    prompt_title = "grove · tasks" .. title_suffix,
    finder = finders.new_table({
      results = tasks,
      entry_maker = function(task)
        return {
          value   = task,
          display = format_entry(task, widths),
          ordinal = table.concat({ task.id, task.title, task.repo, task.status }, " "),
        }
      end,
    }),
    sorter  = conf.generic_sorter({}),
    previewer = make_previewer(),
    attach_mappings = function(prompt_bufnr, map)

      -- <C-a>: toggle done tasks and reopen picker
      map("i", "<C-a>", function()
        actions.close(prompt_bufnr)
        show_done = not show_done
        -- Re-open with the same task list (already fully loaded)
        vim.schedule(function()
          M.open(all_tasks)
        end)
      end)

      -- "/": open function picker (create task, etc.)
      map("i", "/", function()
        actions.close(prompt_bufnr)
        vim.schedule(function()
          M.open_function_picker(git_dir)
        end)
      end)

      -- <Tab>: task action menu (kill session / delete task)
      map("i", "<Tab>", function()
        local selection = action_state.get_selected_entry()
        if not selection then return end
        actions.close(prompt_bufnr)

        vim.schedule(function()
          local task = selection.value
          local has_session = tmux.session_exists(tmux.session_name(task))
          local session_label = has_session and "Kill session (keep task)" or "Kill session (keep task) — no active session"

          vim.ui.select(
            { session_label, "Delete task + kill session" },
            { prompt = "grove · " .. task.id .. " · " .. task.title .. ": " },
            function(choice)
              if not choice then
                -- Cancelled — reopen picker unchanged
                M.open(all_tasks)
                return
              end

              if choice:find("Delete task") then
                tmux.kill_session(task)
                vim.fn.delete(task.path)
                vim.notify(
                  string.format("grove: deleted %s and killed session", task.id),
                  vim.log.levels.INFO
                )
              else
                if has_session then
                  tmux.kill_session(task)
                  vim.notify(
                    string.format("grove: killed session for %s", task.id),
                    vim.log.levels.INFO
                  )
                else
                  vim.notify("grove: no active session for " .. task.id, vim.log.levels.INFO)
                end
              end

              -- Refresh task list and reopen picker
              local cfg = require("grove.config").get()
              local new_tasks = require("grove.tasks").load_all(cfg.git_dir)
              M.open(new_tasks)
            end
          )
        end)
      end)

      -- <CR>: jump to selected task
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if not selection then return end

        -- Defer to ensure Telescope is fully closed before any vim.ui calls
        vim.schedule(function()
          tmux.jump_to_task(selection.value, nil)
        end)
      end)

      return true
    end,
  }):find()
end

return M
