return {
  -- Core parser installer (new API — no configs module)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      -- New API: setup only accepts install_dir override
      require("nvim-treesitter").setup()

      -- Install parsers
      require("nvim-treesitter.install").install({
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "python",
        "json",
        "jsonc",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
        "bash",
        "regex",
        "vim",
        "vimdoc",
        "query",
      })

      -- Enable treesitter highlighting + indentation per buffer
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })

      -- Textobjects: setup options
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      -- Textobjects: select keymaps
      local select = require("nvim-treesitter-textobjects.select")
      local mode = { "x", "o" }
      vim.keymap.set(mode, "af", function() select.select_textobject("@function.outer", "textobjects") end, { desc = "outer function" })
      vim.keymap.set(mode, "if", function() select.select_textobject("@function.inner", "textobjects") end, { desc = "inner function" })
      vim.keymap.set(mode, "ac", function() select.select_textobject("@class.outer", "textobjects") end, { desc = "outer class" })
      vim.keymap.set(mode, "ic", function() select.select_textobject("@class.inner", "textobjects") end, { desc = "inner class" })
      vim.keymap.set(mode, "aa", function() select.select_textobject("@parameter.outer", "textobjects") end, { desc = "outer parameter" })
      vim.keymap.set(mode, "ia", function() select.select_textobject("@parameter.inner", "textobjects") end, { desc = "inner parameter" })

      -- Textobjects: move keymaps
      local move = require("nvim-treesitter-textobjects.move")
      vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer") end, { desc = "Next function start" })
      vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer") end, { desc = "Prev function start" })
      vim.keymap.set({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer") end, { desc = "Next function end" })
      vim.keymap.set({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer") end, { desc = "Prev function end" })
      vim.keymap.set({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer") end, { desc = "Next class start" })
      vim.keymap.set({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer") end, { desc = "Prev class start" })

      -- Textobjects: swap keymaps
      local swap = require("nvim-treesitter-textobjects.swap")
      vim.keymap.set("n", "<leader>sn", function() swap.swap_next("@parameter.inner") end, { desc = "Swap next parameter" })
      vim.keymap.set("n", "<leader>sp", function() swap.swap_previous("@parameter.inner") end, { desc = "Swap prev parameter" })

      -- Autotag
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Context-aware comment strings (used by Comment.nvim)
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = { enable_autocmd = false },
  },
}
