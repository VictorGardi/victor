return {
  -- Rich in-buffer markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>mt", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle markdown render" },
    },
    opts = {
      enabled = true,
      render_modes = { "n", "c" },
      heading = {
        enabled = true,
        sign = false,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      code = {
        enabled = true,
        sign = false,
        style = "full",
        border = "thin",
      },
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰱒 " },
      },
    },
  },

  -- Browser markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install && git checkout -- yarn.lock",
    keys = {
      { "<leader>mb", "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle markdown browser preview" },
    },
  },
}
