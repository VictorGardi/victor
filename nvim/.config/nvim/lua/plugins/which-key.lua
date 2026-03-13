return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    spec = {
      { "<leader>r", group = "review" },
      { "<leader>m", group = "markdown" },
      { "<leader>g", group = "git" },
      { "<leader>h", group = "hunks" },
      { "<leader>f", group = "find" },
      { "<leader>x", group = "diagnostics" },
    },
  },
}
