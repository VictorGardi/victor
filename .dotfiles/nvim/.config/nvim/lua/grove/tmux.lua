-- grove/tmux.lua
-- Manages tmux sessions for grove tasks.

local M = {}

---Build the grove session name for a task.
---Format: grove-T-104-fix-auth-bug
---@param task { id: string, title: string }
---@return string
function M.session_name(task)
  local template = require("grove.template")
  local slug = template.slugify(task.title)
  return "grove-" .. task.id .. "-" .. slug
end

---Check whether a tmux session exists.
---@param name string
---@return boolean
function M.session_exists(name)
  vim.fn.system("tmux has-session -t " .. vim.fn.shellescape(name) .. " 2>/dev/null")
  return vim.v.shell_error == 0
end

---Create a tmux session with two windows:
---  1. Agent window  — runs the chosen agent (opencode / claude)
---  2. Editor window — runs nvim . in the repo root, named after the repo
---Lands on the agent window when done.
---@param session  string
---@param task     { repo_path: string, repo: string }
---@param agent    string
function M.create_session(session, task, agent)
  -- Create detached session; first window is named after the agent.
  -- Use -d and -s as separate flags to avoid any shell parsing ambiguity.
  vim.fn.system(string.format(
    "tmux new-session -d -s %s -c %s -n %s",
    vim.fn.shellescape(session),
    vim.fn.shellescape(task.repo_path),
    vim.fn.shellescape(agent)
  ))

  -- Target windows by name (session:window-name) so base-index never matters.

  -- Start the agent in its named window
  vim.fn.system(string.format(
    "tmux send-keys -t %s %s Enter",
    vim.fn.shellescape(session .. ":" .. agent),
    vim.fn.shellescape(agent)
  ))

  -- Create the editor window named after the repo
  vim.fn.system(string.format(
    "tmux new-window -t %s -n %s -c %s",
    vim.fn.shellescape(session),
    vim.fn.shellescape(task.repo),
    vim.fn.shellescape(task.repo_path)
  ))

  -- Start nvim in the editor window
  vim.fn.system(string.format(
    "tmux send-keys -t %s %s Enter",
    vim.fn.shellescape(session .. ":" .. task.repo),
    vim.fn.shellescape("nvim .")
  ))

  -- Land on the agent window
  vim.fn.system(string.format(
    "tmux select-window -t %s",
    vim.fn.shellescape(session .. ":" .. agent)
  ))
end

---Switch the tmux client to the named session.
---@param name string
function M.switch_to(name)
  vim.fn.system("tmux switch-client -t " .. vim.fn.shellescape(name))
end

---Switch back to the previously active tmux session.
function M.back()
  if not M.in_tmux() then
    vim.notify("grove: not inside a tmux session", vim.log.levels.WARN)
    return
  end
  vim.fn.system("tmux switch-client -l")
end

---Kill the tmux session for a task if it exists.
---@param task { id: string, title: string }
function M.kill_session(task)
  local name = M.session_name(task)
  if M.session_exists(name) then
    vim.fn.system("tmux kill-session -t " .. vim.fn.shellescape(name))
  end
end

---Check whether Neovim is running inside a tmux session.
---@return boolean
function M.in_tmux()
  return os.getenv("TMUX") ~= nil
end

---Full jump-to-task flow.
---  Existing session → switch immediately.
---  No session       → prompt for agent → create two-window session → switch.
---Must be called after Telescope is closed (use vim.schedule if needed).
---@param task  { id: string, title: string, repo: string, repo_path: string }
---@param agent string|nil  skip prompt when provided
function M.jump_to_task(task, agent)
  if not M.in_tmux() then
    vim.notify("grove: not inside a tmux session — cannot switch", vim.log.levels.WARN)
    return
  end

  local session = M.session_name(task)

  if M.session_exists(session) then
    M.switch_to(session)
    return
  end

  local function launch(chosen_agent)
    M.create_session(session, task, chosen_agent)
    M.switch_to(session)
  end

  if agent then
    launch(agent)
  else
    vim.ui.select(
      { "opencode", "claude" },
      { prompt = "grove · choose agent for " .. task.id .. ": " },
      function(choice)
        if choice then launch(choice) end
      end
    )
  end
end

return M
