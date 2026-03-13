return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  init = function()
    local autoformat_group = vim.api.nvim_create_augroup("PythonAutoFormat", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = autoformat_group,
      pattern = "*",
      callback = function(args)
        vim.b[args.buf].autoformat = vim.bo[args.buf].filetype == "python"
      end,
    })
  end,
  opts = {
    default_format_opts = {
      lsp_format = "fallback",
      timeout_ms = 1000,
      async = false,
    },
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      liquid = { "prettier" },
      lua = { "stylua" },
      python = { "ruff_organize_imports", "ruff_format" },
    },
    -- Configure ruff to use pyproject.toml
    formatters = {
      ruff_format = {
        command = "ruff",
        args = {
          "format",
          "--force-exclude",
          "--stdin-filename",
          "$FILENAME",
          "-",
        },
      },
      ruff_organize_imports = {
        command = "ruff",
        args = {
          "check",
          "--select",
          "I",
          "--fix",
          "--force-exclude",
          "--stdin-filename",
          "$FILENAME",
          "-",
        },
      },
    },
  },
  keys = {
    {
      "<leader>mf",
      function()
        require("conform").format({ lsp_format = "fallback", async = false, timeout_ms = 1000 })
      end,
      mode = { "n", "v" },
      desc = "Format file or range (in visual mode)",
    },
  },
}
