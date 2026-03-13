return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    require("bufferline").setup({
      highlights = require("catppuccin.groups.integrations.bufferline").get(),
      options = {
        mode = "tabs",
        always_show_bufferline = false,
        show_close_icon = false,
        show_buffer_close_icons = false,
        separator_style = "slant",
        indicator = { style = "underline" },
        color_icons = true,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
      },
    })
  end,
}
