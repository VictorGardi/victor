vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local review_state = {}

local function toggle_reading_mode()
  local win = vim.api.nvim_get_current_win()

  if review_state[win] then
    for option, value in pairs(review_state[win]) do
      vim.wo[win][option] = value
    end
    review_state[win] = nil
    vim.notify("Reading mode disabled", vim.log.levels.INFO)
    return
  end

  review_state[win] = {
    wrap = vim.wo[win].wrap,
    linebreak = vim.wo[win].linebreak,
    breakindent = vim.wo[win].breakindent,
    number = vim.wo[win].number,
    relativenumber = vim.wo[win].relativenumber,
    signcolumn = vim.wo[win].signcolumn,
    cursorline = vim.wo[win].cursorline,
    spell = vim.wo[win].spell,
  }

  vim.wo[win].wrap = true
  vim.wo[win].linebreak = true
  vim.wo[win].breakindent = true
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = "no"
  vim.wo[win].cursorline = false
  vim.wo[win].spell = vim.bo.filetype == "markdown" or vim.bo.filetype == "help"

  vim.notify("Reading mode enabled", vim.log.levels.INFO)
end

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>rr", toggle_reading_mode, { desc = "Toggle reading mode" })
keymap.set("n", "<leader>rg", "<cmd>G<CR>", { desc = "Review git status" })
keymap.set("n", "<leader>rd", "<cmd>Gdiffsplit<CR>", { desc = "Review git diff" })
keymap.set("n", "<leader>rc", "<cmd>Telescope git_bcommits<CR>", { desc = "Review file history" })
keymap.set("n", "<leader>rC", "<cmd>Telescope git_commits<CR>", { desc = "Review repo history" })
keymap.set("n", "<leader>rp", function()
  require("gitsigns").preview_hunk()
end, { desc = "Review hunk preview" })
keymap.set("n", "<leader>rb", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Review blame line" })

-- Window navigation with leader + arrow keys
keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Window resizing with arrow keys (easier than Ctrl+w +/-)
keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height", silent = true })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height", silent = true })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width", silent = true })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width", silent = true })

-- Alternative: Use Shift + arrow keys for resizing (in case Ctrl conflicts)
keymap.set("n", "<S-Up>", ":resize +2<CR>", { desc = "Increase window height", silent = true })
keymap.set("n", "<S-Down>", ":resize -2<CR>", { desc = "Decrease window height", silent = true })
keymap.set("n", "<S-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width", silent = true })
keymap.set("n", "<S-Right>", ":vertical resize +2<CR>", { desc = "Increase window width", silent = true })

-- Make all windows equal size with a simple keymap
keymap.set("n", "<leader>=", "<C-w>=", { desc = "Make all windows equal size", noremap = true, silent = true })
keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Make all windows equal size", noremap = true, silent = true })
--keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
-- Variable to track if terminal buffer exists
local term_buf = nil

-- Function to toggle terminal
local function toggle_terminal()
  -- Check if terminal buffer exists and is valid
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    -- Check if terminal is visible in any window
    local term_win = vim.fn.bufwinid(term_buf)
    if term_win ~= -1 then
      -- Terminal is visible, close it
      vim.api.nvim_win_close(term_win, false)
    else
      -- Terminal exists but not visible, show it in a split
      vim.cmd("split")
      vim.api.nvim_win_set_buf(0, term_buf)
      vim.cmd("startinsert")
    end
  else
    -- Terminal doesn't exist, create it
    vim.cmd("split | terminal")
    term_buf = vim.api.nvim_get_current_buf()
    vim.cmd("startinsert")
  end
end

-- Map the toggle function to Ctrl+\ (and keep <leader>j as alternative)
-- Note: Ctrl+j conflicts with window navigation, so using Ctrl+\
vim.keymap.set("n", "<C-\\>", toggle_terminal, { noremap = true, silent = true, desc = "Toggle terminal" })
vim.keymap.set("t", "<C-\\>", toggle_terminal, { noremap = true, silent = true, desc = "Toggle terminal" }) -- Works in terminal mode
vim.keymap.set("n", "<leader>j", toggle_terminal, { noremap = true, silent = true, desc = "Toggle terminal" })

-- Easy escape from terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" })
