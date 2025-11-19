return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy", -- Lazy load to improve startup
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
    },
  },
}
