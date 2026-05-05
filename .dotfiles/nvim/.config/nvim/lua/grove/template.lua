-- grove/template.lua
-- Handles task file creation: ID generation, slugification, directory
-- bootstrapping, and writing the full task-format template.

local M = {}

local STATUS_DIRS = { "backlog", "doing", "review", "done" }

---Ensure all .tasks/ subdirectories exist in a repo.
---@param repo_path string
function M.ensure_dirs(repo_path)
  for _, status in ipairs(STATUS_DIRS) do
    vim.fn.mkdir(repo_path .. "/.tasks/" .. status, "p")
  end
end

---Scan all .tasks/**/*.md in a repo and return the next T-NNN id.
---@param repo_path string
---@return string  e.g. "T-042"
function M.next_id(repo_path)
  local pattern = repo_path .. "/.tasks/**/*.md"
  local files = vim.fn.glob(pattern, false, true)

  local max_n = 0
  for _, filepath in ipairs(files) do
    local filename = vim.fn.fnamemodify(filepath, ":t")
    local n = filename:match("^T%-(%d+)")
    if n then
      max_n = math.max(max_n, tonumber(n))
    end
  end

  return string.format("T-%03d", max_n + 1)
end

---Convert a title string into a URL-safe slug.
---@param title string
---@return string
function M.slugify(title)
  local slug = title:lower()
  slug = slug:gsub("[^%w%s%-]", "")   -- remove non-word, non-space, non-hyphen
  slug = slug:gsub("%s+", "-")         -- spaces → hyphens
  slug = slug:gsub("%-+", "-")         -- collapse multiple hyphens
  slug = slug:gsub("^%-+", "")         -- strip leading hyphens
  slug = slug:gsub("%-+$", "")         -- strip trailing hyphens
  return slug
end

---Build the full task file content string.
---@param id        string
---@param title     string
---@param repo_name string
---@return string
function M.build_content(id, title, repo_name)
  local date = os.date("%Y-%m-%d")
  return string.format([[---
id: %s
title: %s
status: backlog
priority: medium
created_at: %s
workspace: %s
---

# Goal

%s

# Context

<!-- Add background, constraints, and relevant links here -->

# Implementation Plan

1. <!-- Step 1 -->

# Definition of Done

- [ ] <!-- Criterion 1 -->

# Risks

- <!-- Risk 1 -->

# Notes

Generated via grove.nvim
]], id, title, date, repo_name, title)
end

---Create a new task file in .tasks/backlog/ of the given repo.
---Bootstraps .tasks/ directories if they don't exist.
---@param repo_path string
---@param repo_name string
---@param title     string  human-readable task title
---@return table task  the newly created task object
function M.create(repo_path, repo_name, title)
  M.ensure_dirs(repo_path)

  local id   = M.next_id(repo_path)
  local slug = M.slugify(title)
  local filename = id .. "-" .. slug .. ".md"
  local filepath = repo_path .. "/.tasks/backlog/" .. filename

  local content = M.build_content(id, title, repo_name)

  -- Write file line by line
  local lines = vim.split(content, "\n", { plain = true })
  -- Remove trailing empty element if content ends with newline
  if lines[#lines] == "" then
    table.remove(lines)
  end
  vim.fn.writefile(lines, filepath)

  return {
    id        = id,
    title     = title,
    status    = "backlog",
    repo      = repo_name,
    repo_path = repo_path,
    path      = filepath,
  }
end

return M
