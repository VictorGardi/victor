-- grove/init.lua
-- Public API for grove.nvim.
--
-- Usage:
--   require("grove").setup({ git_dir = "~/git" })
--   require("grove").tasks()

local M = {}

---Configure grove. Call this from your lazy.nvim spec's config function.
---@param opts? { git_dir?: string }
function M.setup(opts)
  require("grove.config").setup(opts)
end

---Open the grove task picker.
---Scans all repos on every call (fast for small repo sets).
function M.tasks()
  local config = require("grove.config")
  local tasks  = require("grove.tasks")
  local picker = require("grove.picker")

  local git_dir  = config.get().git_dir
  local all_tasks = tasks.load_all(git_dir)

  picker.open(all_tasks)
end

return M
