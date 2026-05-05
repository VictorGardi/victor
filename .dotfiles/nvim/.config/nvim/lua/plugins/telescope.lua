return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>fG", "<cmd>Telescope git_files<CR>", desc = "Git files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<leader>fc", "<cmd>Telescope grep_string<CR>", desc = "Find word under cursor" },
      { "<leader>fl", "<cmd>TodoTelescope<CR>", desc = "Find todos" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Open buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
      -- Review keymaps (git history)
      { "<leader>rc", "<cmd>Telescope git_bcommits<CR>", desc = "Review file commits" },
      { "<leader>rC", "<cmd>Telescope git_commits<CR>", desc = "Review repo commits" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "smart" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<Esc>"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = { hidden = true },
        },
      })

      pcall(telescope.load_extension, "fzf")
    end,
  },

  { "nvim-lua/plenary.nvim", lazy = true },
}
