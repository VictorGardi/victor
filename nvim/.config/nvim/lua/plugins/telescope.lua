return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  keys = {
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Find files in cwd",
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Search text in cwd",
    },
    {
      "<leader>fG",
      function()
        require("telescope.builtin").git_files()
      end,
      desc = "Find git files",
    },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Fuzzy find recent files" },
    { "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find string under cursor in cwd" },
    { "<leader>fl", "<cmd>TodoTelescope<cr>", desc = "Find todos" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        file_ignore_patterns = { "venv" },
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.open,
          },
        },
      },
    })

    telescope.load_extension("fzf")
  end,
}
