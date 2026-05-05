-- lua/plugins/grove.lua
-- Lazy.nvim spec for grove.nvim — the global task switcher.
--
-- grove lives inside the nvim config itself (lua/grove/), so we point lazy
-- at the config dir and give it a name so it doesn't conflict with anything.

return {
  {
    -- Load as a local plugin from within the nvim config directory
    dir = vim.fn.stdpath("config"),
    name = "grove.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    -- Only load when the keymap is triggered or the command is called
    keys = {
      {
        "<leader>gt",
        function() require("grove").tasks() end,
        desc = "Grove: task switcher",
      },
      {
        "<leader>gb",
        function() require("grove.tmux").back() end,
        desc = "Grove: back to previous session",
      },
    },
    cmd = { "Grove" },
    config = function()
      require("grove").setup({
        git_dir = vim.fn.expand("~/git"),
      })

      -- Optional: expose a :Grove command as an alternative to the keymap
      vim.api.nvim_create_user_command("Grove", function()
        require("grove").tasks()
      end, { desc = "Open grove task switcher" })
    end,
  },
}
