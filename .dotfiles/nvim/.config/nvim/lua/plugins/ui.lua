return {
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "rose-pine",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "snacks_dashboard" },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { "filename", path = 1 },
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            symbols = { error = " ", warn = " ", info = " ", hint = "󰝶 " },
          },
        },
        lualine_x = { "diff", "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Keymap popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 300,
      icons = {
        mappings = true,
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Hunks" },
        { "<leader>r", group = "Review/Rename" },
        { "<leader>s", group = "Splits/Swap" },
        { "<leader>t", group = "Tabs" },
        { "<leader>x", group = "Diagnostics" },
        { "<leader>m", group = "Markdown" },
        { "<leader>e", group = "Explorer" },
        { "<leader>c", group = "Code" },
      })
    end,
  },

  -- TODO/FIXME highlights
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous TODO" },
    },
    opts = { signs = false },
  },

  -- Diagnostics / quickfix list
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
      { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Workspace diagnostics" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Location list" },
      { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "TODOs" },
    },
    opts = {
      modes = {
        diagnostics = { auto_close = true },
      },
    },
  },
}
