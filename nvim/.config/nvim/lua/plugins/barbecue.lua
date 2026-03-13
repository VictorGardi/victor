return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  event = "BufReadPre",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    theme = "catppuccin",
    show_dirname = false,
    show_basename = false,
    show_modified = true,
    symbols = {
      separator = "",
    },
  },
}
