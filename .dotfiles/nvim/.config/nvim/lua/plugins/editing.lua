return {
  -- Surround pairs (cs, ds, ys)
  {
    "kylechui/nvim-surround",
    event = { "BufReadPost", "BufNewFile" },
    version = "*",
    opts = {},
  },

  -- Auto-close brackets/quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- use treesitter to check pairs
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        java = false,
      },
    },
    config = function(_, opts)
      local autopairs = require("nvim-autopairs")
      autopairs.setup(opts)
      -- Connect to blink.cmp
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        blink.on_confirm_done = autopairs.on_confirm_done
      end
    end,
  },

  -- Smart comment toggling
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
}
