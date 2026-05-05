return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>mf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format file",
      },
    },
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
        python = { "ruff_format", "ruff_organize_imports" },
      },
      -- Auto-format on save for Python only
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        if ft == "python" then
          return { timeout_ms = 500, lsp_fallback = true }
        end
      end,
    },
  },
}
