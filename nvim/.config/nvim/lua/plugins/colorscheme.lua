return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    require("everforest").setup({
      background = "hard", -- Options: "hard", "medium", "soft"
      transparent_background_level = 2, -- 0 = no transparency, 1 = partial, 2 = full transparency
      italics = false,
      disable_italic_comments = false,
      sign_column_background = "none",
      ui_contrast = "low", -- "low" or "high"
      dim_inactive_windows = false,
      diagnostic_text_highlight = false,
      diagnostic_virtual_text = "coloured",
      diagnostic_line_highlight = false,
      spell_foreground = false,
      show_eob = true,
      float_style = "bright", -- "bright" or "dim"
      on_highlights = function(hl, palette)
        -- You can customize highlights here if needed
      end,
      colours_override = function(palette)
        -- You can override colors here if needed
      end,
    })

    vim.cmd("colorscheme everforest")
    
    -- Set transparent backgrounds for Avante and other floating windows
    vim.cmd([[
      " Make all floating windows transparent
      highlight NormalFloat guibg=NONE ctermbg=NONE
      highlight FloatBorder guibg=NONE ctermbg=NONE
      
      " Avante-specific highlights with better visibility
      highlight AvanteTitle guifg=#A7C080 gui=bold guibg=NONE ctermbg=NONE
      highlight AvanteReversedTitle guifg=#A7C080 gui=bold guibg=NONE ctermbg=NONE
      highlight AvanteSubtitle guifg=#D3C6AA gui=italic guibg=NONE ctermbg=NONE
      highlight AvanteReversedSubtitle guifg=#D3C6AA gui=italic guibg=NONE ctermbg=NONE
      highlight AvanteThirdTitle guifg=#7FBBB3 guibg=NONE ctermbg=NONE
      highlight AvanteReversedThirdTitle guifg=#7FBBB3 guibg=NONE ctermbg=NONE
      
      " NUI components (used by Avante)
      highlight NuiNormal guibg=NONE ctermbg=NONE
      highlight NuiNormalNC guibg=NONE ctermbg=NONE
    ]])
  end,
}
