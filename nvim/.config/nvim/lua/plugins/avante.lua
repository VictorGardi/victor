return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    provider = "copilot",
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false, -- This is the key setting!
      support_paste_from_clipboard = false,
    },
    windows = {
      wrap = true,
      width = 30, -- Sidebar width percentage
      sidebar_header = {
        enabled = false, -- Disable the decorative header with icons
        align = "center",
      },
    },
    highlights = {
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },
    mappings = {
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
      },
    },
  },
  config = function(_, opts)
    require("avante").setup(opts)
    
    -- Match Avante sidebar colors with editor (for transparency)
    -- Set all Avante highlight groups to use transparent background
    vim.cmd([[
      " Avante window backgrounds
      highlight AvanteTitle guibg=NONE ctermbg=NONE
      highlight AvanteReversedTitle guibg=NONE ctermbg=NONE
      highlight AvanteSubtitle guibg=NONE ctermbg=NONE
      highlight AvanteReversedSubtitle guibg=NONE ctermbg=NONE
      highlight AvanteThirdTitle guibg=NONE ctermbg=NONE
      highlight AvanteReversedThirdTitle guibg=NONE ctermbg=NONE
      highlight AvanteConflictCurrent guibg=NONE ctermbg=NONE
      highlight AvanteConflictIncoming guibg=NONE ctermbg=NONE
      highlight AvanteConflictCurrentLabel guibg=NONE ctermbg=NONE
      highlight AvanteConflictIncomingLabel guibg=NONE ctermbg=NONE
      
      " NuiNormal is used by Avante's NUI components
      highlight link NuiNormal Normal
      highlight NuiNormal guibg=NONE ctermbg=NONE
      
      " Avante-specific normal backgrounds
      highlight link AvanteNormal Normal
      highlight AvanteNormal guibg=NONE ctermbg=NONE
    ]])
    
    -- Also set it as an autocmd for when Avante windows open
    vim.api.nvim_create_autocmd({"FileType", "BufEnter"}, {
      pattern = {"Avante", "AvanteInput"},
      callback = function()
        vim.cmd([[
          setlocal winhighlight=Normal:Normal,NormalNC:Normal
        ]])
      end,
    })
  end,
  keys = {
    {
      "<C-r>",
      function()
        require("avante.api").ask()
      end,
      desc = "Avante: Ask AI",
      mode = { "n", "v" },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-mini/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
}
