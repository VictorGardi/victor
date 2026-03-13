return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown", "markdown_inline", "codecompanion" },
  opts = {
    enabled = true,
    render_modes = { "n", "c" },
    max_file_size = 10.0,
    debounce = 100,
    heading = {
      enabled = true,
      sign = false,
      position = "left",
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      width = "block",
      left_pad = 1,
      right_pad = 1,
      min_width = 0,
      border = false,
    },
    code = {
      enabled = true,
      style = "full",
      position = "left",
      language_pad = 1,
    },
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
      left_pad = 0,
      right_pad = 1,
    },
    checkbox = {
      enabled = true,
      position = "overlay",
      unchecked = { icon = "󰄱 ", highlight = "RenderMarkdownUnchecked" },
      checked = { icon = "󰱒 ", highlight = "RenderMarkdownChecked" },
    },
    quote = {
      enabled = true,
      icon = "│",
      repeat_linebreak = false,
    },
    pipe_table = {
      enabled = true,
      style = "compact",
      cell = "both",
      padding = 1,
    },
    link = {
      enabled = true,
      image = "󰥶 ",
      email = "󰀓 ",
      hyperlink = "󰌹 ",
      highlight = "RenderMarkdownLink",
    },
    win_options = {
      conceallevel = {
        default = vim.api.nvim_get_option_value("conceallevel", {}),
        rendered = 3,
      },
    },
  },
  keys = {
    {
      "<leader>mt",
      function()
        require("render-markdown").toggle()
      end,
      desc = "Toggle Markdown Render",
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)
  end,
}
