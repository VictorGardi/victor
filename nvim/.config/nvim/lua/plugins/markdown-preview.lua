return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = "cd app && npm install",
  keys = {
    { "<leader>mb", "<cmd>MarkdownPreviewToggle<CR>", ft = "markdown", desc = "Toggle browser preview" },
  },
  init = function()
    vim.g.mkdp_auto_close = 1    -- close preview when buffer is closed
    vim.g.mkdp_refresh_slow = 0  -- refresh in real-time
    vim.g.mkdp_open_to_the_world = 0
    vim.g.mkdp_theme = "dark"
  end,
}
