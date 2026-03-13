return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewFocusFiles", "DiffviewToggleFiles" },
  keys = {
    { "<leader>rv", "<cmd>DiffviewOpen<CR>", desc = "Open diffview (all changes)" },
    { "<leader>rh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
    { "<leader>rH", "<cmd>DiffviewFileHistory<CR>", desc = "Repo history" },
    { "<leader>rq", "<cmd>DiffviewClose<CR>", desc = "Close diffview" },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = {
        layout = "diff2_horizontal",
      },
      file_history = {
        layout = "diff2_horizontal",
      },
    },
    file_panel = {
      listing_style = "tree",
      win_config = {
        position = "left",
        width = 35,
      },
    },
    hooks = {
      diff_buf_read = function(bufnr)
        vim.opt_local.wrap = false
        vim.opt_local.list = false
        vim.opt_local.relativenumber = false
        vim.opt_local.cursorline = false
      end,
      view_opened = function()
        -- Modern, GitHub-inspired diff colors (subtle tints over tokyonight dark)
        vim.api.nvim_set_hl(0, "DiffAdd",    { bg = "#1a2e22", fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#2e1a1e", fg = "#6b6b6b" })
        vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1a2233", fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffText",   { bg = "#1e3a5f", fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffviewDiffAddAsDelete", { bg = "#2e1a1e" })
        vim.api.nvim_set_hl(0, "DiffviewDiffDelete",      { bg = "#2e1a1e", fg = "#4a3030" })
      end,
    },
  },
}
