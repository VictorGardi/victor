return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
  version = "*",
  config = function()
    local highlights = {}
    local ok, catppuccin_bl = pcall(require, "catppuccin.groups.integrations.bufferline")
    if ok then
      highlights = catppuccin_bl.get()
    end

    require("bufferline").setup({
      highlights = highlights,
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
