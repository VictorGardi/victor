return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
  ██╗   ██╗██╗███╗   ███╗
  ██║   ██║██║████╗ ████║
  ██║   ██║██║██╔████╔██║
  ╚██╗ ██╔╝██║██║╚██╔╝██║
   ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        keys = {
          { icon = " ", key = "f", desc = "Find File",       action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "r", desc = "Recent Files",    action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "g", desc = "Find Text",       action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "d", desc = "Diffview",        action = ":DiffviewOpen" },
          { icon = "󰊢", key = "G", desc = "Git Status",      action = ":G" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲", key = "l", desc = "Lazy",            action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit",            action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "recent_files", limit = 8, title = "Recent Files", padding = 1 },
        { section = "startup" },
      },
    },
  },
}
