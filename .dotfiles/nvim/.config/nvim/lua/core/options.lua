-- Disable netrw (using snacks explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Leader keys (must be set before lazy loads plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Line numbers
opt.relativenumber = true
opt.number = true

-- Tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Line wrapping
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.conceallevel = 2

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Splits
opt.splitright = true
opt.splitbelow = true
opt.diffopt:append("linematch:60")

-- Misc
opt.swapfile = false
opt.mouse = "a"
opt.updatetime = 250
opt.timeoutlen = 300

-- Diagnostics
vim.diagnostic.config({
  float = { border = "rounded", source = true },
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = true,
})
