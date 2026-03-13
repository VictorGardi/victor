return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy", -- Lazy load to improve startup
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      always_show_bufferline = false,
      show_close_icon = false,
      show_buffer_close_icons = false,
      separator_style = "thin",
    },
  },
}
