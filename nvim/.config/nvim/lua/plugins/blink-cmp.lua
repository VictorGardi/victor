return {
  "saghen/blink.cmp",
  enabled = false, -- Disabled in favor of nvim-cmp
  opts = {
    completion = {
      menu = {
        draw = {
          treesitter = false, -- Disable treesitter highlighting in completion menu
        },
      },
    },
  },
}
