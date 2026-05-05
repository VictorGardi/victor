-- grove/tasks.lua
-- Scans ~/git repos and parses .tasks/**/*.md files into a unified task list.

local M = {}

-- Status sort weight: lower = shown first
M.STATUS_ORDER = {
  doing   = 1,
  review  = 2,
  backlog = 3,
  done    = 4,
}

---Parse YAML frontmatter from a markdown file.
---Reads lines until the closing "---" and extracts id + title.
---@param filepath string
---@return { id: string, title: string }
function M.parse_frontmatter(filepath)
  local result = { id = nil, title = nil }

  local ok, lines = pcall(vim.fn.readfile, filepath)
  if not ok or #lines == 0 then
    return result
  end

  -- First line must be opening "---"
  if vim.trim(lines[1]) ~= "---" then
    return result
  end

  for i = 2, math.min(#lines, 30) do
    local line = lines[i]
    if vim.trim(line) == "---" then
      break
    end

    local key, value = line:match("^(%w[%w_%-]*):%s*(.+)$")
    if key and value then
      value = vim.trim(value)
      if key == "id" then
        result.id = value
      elseif key == "title" then
        result.title = value
      end
    end
  end

  return result
end

---Derive a task ID and title from the filename as fallback.
---Filename pattern: T-NNN-some-slug.md
---@param filepath string
---@return string id, string title
function M.parse_filename(filepath)
  local filename = vim.fn.fnamemodify(filepath, ":t:r") -- stem without extension
  local id = filename:match("^(T%-%d+)") or filename
  -- Title: strip the T-NNN- prefix, replace hyphens with spaces, title-case
  local slug = filename:gsub("^T%-%d+%-", "")
  local title = slug:gsub("%-", " ")
  -- Capitalise first letter
  title = title:sub(1, 1):upper() .. title:sub(2)
  return id, title
end

---Scan a single repo for task files.
---@param repo { name: string, path: string }
---@return table[] tasks
function M.scan_tasks(repo)
  local tasks = {}
  local pattern = repo.path .. "/.tasks/**/*.md"
  local files = vim.fn.glob(pattern, false, true)

  for _, filepath in ipairs(files) do
    -- Derive status from the parent directory name
    local parent_dir = vim.fn.fnamemodify(filepath, ":h:t")
    local status = parent_dir

    -- Only process known status directories
    if M.STATUS_ORDER[status] then
      local fm = M.parse_frontmatter(filepath)
      local fb_id, fb_title = M.parse_filename(filepath)

      local id    = (fm.id    and fm.id    ~= "") and fm.id    or fb_id
      local title = (fm.title and fm.title ~= "") and fm.title or fb_title

      table.insert(tasks, {
        id        = id,
        title     = title,
        status    = status,
        repo      = repo.name,
        repo_path = repo.path,
        path      = filepath,
      })
    end
  end

  return tasks
end

---Find all git repos under git_dir.
---A repo is any direct subdirectory that contains a .git directory.
---@param git_dir string
---@return table[] repos
function M.scan_repos(git_dir)
  local repos = {}
  local entries = vim.fn.glob(git_dir .. "/*/", false, true)

  for _, entry in ipairs(entries) do
    -- Remove trailing slash
    local path = entry:gsub("/$", "")
    if vim.fn.isdirectory(path .. "/.git") == 1 then
      local name = vim.fn.fnamemodify(path, ":t")
      table.insert(repos, { name = name, path = path })
    end
  end

  return repos
end

---Load and sort all tasks across all repos under git_dir.
---@param git_dir string
---@return table[] tasks
function M.load_all(git_dir)
  local repos = M.scan_repos(git_dir)
  local all = {}

  for _, repo in ipairs(repos) do
    local repo_tasks = M.scan_tasks(repo)
    vim.list_extend(all, repo_tasks)
  end

  -- Sort by status priority, then repo name, then task id
  table.sort(all, function(a, b)
    local wa = M.STATUS_ORDER[a.status] or 99
    local wb = M.STATUS_ORDER[b.status] or 99
    if wa ~= wb then
      return wa < wb
    end
    if a.repo ~= b.repo then
      return a.repo < b.repo
    end
    return a.id < b.id
  end)

  return all
end

return M
