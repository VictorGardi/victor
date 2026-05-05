local review_group = vim.api.nvim_create_augroup("ReviewContext", { clear = true })

local function apply_diff_window_options()
  if not vim.wo.diff then
    return
  end

  vim.opt_local.wrap = false
  vim.opt_local.cursorline = false
  vim.opt_local.relativenumber = false
  vim.opt_local.foldcolumn = "0"
end

vim.api.nvim_create_autocmd("FileType", {
  group = review_group,
  pattern = { "markdown", "help" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = review_group,
  pattern = { "fugitive", "git", "gitcommit" },
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  group = review_group,
  callback = apply_diff_window_options,
})
