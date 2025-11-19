return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  -- Override LazyVim's telescope completely
  opts = function()
    return {}
  end,
  keys = function()
    -- Return empty keys to override all LazyVim defaults
    return {}
  end,
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

    -- Delete any existing keymaps for these keys (from LazyVim or elsewhere)
    pcall(vim.keymap.del, "n", "<leader>ff")
    pcall(vim.keymap.del, "n", "<leader>fg")
    pcall(vim.keymap.del, "n", "<leader>fG")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    -- Find files (always search all files, not just git files)
    keymap.set("n", "<leader>ff", function()
      require("telescope.builtin").find_files()
    end, { desc = "Find files in cwd", noremap = true, silent = true })

    -- Live grep (search within files)
    keymap.set("n", "<leader>fg", function()
      vim.notify("Running live_grep from telescope.lua config", vim.log.levels.INFO)
      require("telescope.builtin").live_grep()
    end, { desc = "Search text in cwd", noremap = true, silent = true })

    -- Git files (separate binding that doesn't conflict)
    keymap.set("n", "<leader>fG", function()
      require("telescope.builtin").git_files()
    end, { desc = "Find git files", noremap = true, silent = true })

    -- Other telescope commands
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>fl", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
  end,
}
