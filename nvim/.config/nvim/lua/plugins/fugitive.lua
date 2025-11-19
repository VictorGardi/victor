-- Git integration with vim-fugitive
return {
  "tpope/vim-fugitive",
  cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove", "GRename" },
  keys = {
    {
      "<leader>gb",
      "<cmd>G blame<CR>",
      desc = "Git blame",
    },
    {
      "<leader>gd",
      "<cmd>Gdiffsplit<CR>",
      desc = "Git diff",
    },
    {
      "<leader>gs",
      "<cmd>G<CR>",
      desc = "Git status",
    },
  },
}
