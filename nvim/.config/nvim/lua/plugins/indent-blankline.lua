return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = { char = "│", tab_char = "│" },
    scope = { enabled = false }, -- scope highlight handled by mini.indentscope
    exclude = {
      filetypes = {
        "help", "alpha", "dashboard", "NvimTree", "neo-tree",
        "Trouble", "lazy", "mason", "notify", "toggleterm",
      },
    },
  },
}
