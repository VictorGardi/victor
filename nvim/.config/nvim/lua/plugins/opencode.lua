return {
  "sudo-tee/opencode.nvim",
  config = function()
    require("opencode").setup({
      keymap_prefix = "<leader>o",
      keymap = {
        editor = {
          ["<D-r>"] = { "toggle" },
        },
      },
      ui = {
        position = "right",
        window_width = 0.40,
      },
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
        file_types = { "markdown", "opencode_output" },
      },
      ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
    },
    "saghen/blink.cmp",
    "folke/snacks.nvim",
  },
  event = "VeryLazy",
}
