return {
  "szw/vim-maximizer",
  enabled = false, -- Disabled - use Ctrl+w | and Ctrl+w = for split management
  keys = {
    { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
  },
}
