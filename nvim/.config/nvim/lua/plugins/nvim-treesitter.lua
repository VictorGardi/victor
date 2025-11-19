local opts = {
  ensure_installed = {
    "bicep",
    "lua",
    "vim",
    "vimdoc",
    "python",
    "markdown",
    "markdown_inline",
  },
  auto_install = false, -- Only install parsers listed above
  -- Ignore parsers with broken/outdated queries
  ignore_install = {
    "angular", "blade", "chatito", "desktop", "gdscript", "gotmpl", "helm",
    "inko", "julia", "koto", "latex", "matlab", "nickel", "nu", "php_only",
    "powershell", "purescript", "snakemake", "swift", "tcl", "tmux", "wit",
    "ziggy_schema"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    -- Disable highlighting for specific languages if they have query errors
    disable = function(lang, buf)
      -- Temporarily disable if we detect query errors
      local ok = pcall(vim.treesitter.query.get, lang, "highlights")
      return not ok
    end,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
}

local function config()
  require("nvim-treesitter.configs").setup(opts)
end

return {
  "nvim-treesitter/nvim-treesitter",
  config = config,
  build = ":TSUpdate",
}
