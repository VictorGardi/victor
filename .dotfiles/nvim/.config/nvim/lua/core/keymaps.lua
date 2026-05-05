local keymap = vim.keymap
local review_state = {}

-- Reading mode toggle
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

-- General
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>rr", toggle_reading_mode, { desc = "Toggle reading mode" })

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Window splits
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equal split sizes" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })
keymap.set("n", "<leader>=", "<C-w>=", { desc = "Equal split sizes", noremap = true, silent = true })

-- Window resizing
keymap.set("n", "<C-Up>", ":resize +2<CR>", { silent = true })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { silent = true })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

-- Tab management
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open buffer in new tab" })

-- Terminal toggle
local term_buf = nil
local function toggle_terminal()
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    local term_win = vim.fn.bufwinid(term_buf)
    if term_win ~= -1 then
      vim.api.nvim_win_close(term_win, false)
    else
      vim.cmd("split")
      vim.api.nvim_win_set_buf(0, term_buf)
      vim.cmd("startinsert")
    end
  else
    vim.cmd("split | terminal")
    term_buf = vim.api.nvim_get_current_buf()
    vim.cmd("startinsert")
  end
end

keymap.set("n", "<C-\\>", toggle_terminal, { noremap = true, silent = true, desc = "Toggle terminal" })
keymap.set("t", "<C-\\>", toggle_terminal, { noremap = true, silent = true, desc = "Toggle terminal" })
keymap.set("n", "<leader>j", toggle_terminal, { noremap = true, silent = true, desc = "Toggle terminal" })
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" })
