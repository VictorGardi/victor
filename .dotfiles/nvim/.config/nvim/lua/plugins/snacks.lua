return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      { "<C-b>", function() Snacks.explorer() end, desc = "Toggle file explorer" },
      { "<leader>ee", function() Snacks.explorer() end, desc = "Toggle file explorer" },
      { "<leader>ef", function() Snacks.explorer({ focus = true }) end, desc = "Focus file explorer" },
    },
    opts = {
      -- File explorer
      explorer = {
        enabled = true,
        replace_netrw = true,
      },

      -- Dashboard
      dashboard = {
        enabled = true,
        preset = {
          header = [[
  ██╗   ██╗██╗███╗   ███╗
  ██║   ██║██║████╗ ████║
  ██║   ██║██║██╔████╔██║
  ╚██╗ ██╔╝██║██║╚██╔╝██║
   ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═══╝  ╚═╝╚═╝     ╚═╝]],
          keys = {
            { icon = " ", key = "f", desc = "Find file", action = ":lua Snacks.picker.files()" },
            { icon = " ", key = "g", desc = "Live Grep", action = ":lua Snacks.picker.grep()" },
            { icon = " ", key = "r", desc = "Recent files", action = ":lua Snacks.picker.recent()" },
            { icon = " ", key = "c", desc = "Config", action = ":e $MYVIMRC" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },

      -- Notifications (replaces vim.notify)
      notifier = {
        enabled = true,
        timeout = 3000,
        style = "compact",
      },

      -- Disable unused modules
      bigfile = { enabled = false },
      quickfile = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
      scroll = { enabled = false },
      animate = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false },
      picker = { enabled = false },
      scope = { enabled = false },
      scratch = { enabled = false },
      terminal = { enabled = false },
      toggle = { enabled = false },
      zen = { enabled = false },
    },
  },
}
