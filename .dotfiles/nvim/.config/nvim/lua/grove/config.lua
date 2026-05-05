-- grove/config.lua
-- Holds grove configuration. Call setup() once from your plugin spec.

local M = {}

M._config = {
  git_dir = vim.fn.expand("~/git"),
}

---@param opts? { git_dir?: string }
function M.setup(opts)
  if opts then
    M._config = vim.tbl_deep_extend("force", M._config, opts)
  end
  -- Expand ~ in git_dir in case user passed an unexpanded string
  M._config.git_dir = vim.fn.expand(M._config.git_dir)
end

---@return { git_dir: string }
function M.get()
  return M._config
end

return M
