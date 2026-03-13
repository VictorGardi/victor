return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "mocha",
    background = { light = "latte", dark = "mocha" },
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = true,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      keywords = {},
      functions = {},
      strings = {},
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      telescope = { enabled = true },
      which_key = true,
      indent_blankline = { enabled = true, scope_color = "lavender", colored_indent_levels = false },
      mini = { enabled = true, indentscope_color = "lavender" },
      lsp_trouble = true,
      bufferline = true,
      noice = true,
      barbecue = { dim_dirname = true, bold_basename = true, dim_context = false, alt_background = false },
      diffview = true,
      render_markdown = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
        inlay_hints = { background = true },
      },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
