return {
  -- LSP progress indicator (tiny, beautiful)
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = { winblend = 0 },
      },
    },
  },

  -- Mason: LSP/tool installer
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "→",
          package_uninstalled = "○",
        },
      },
    },
  },

  -- Auto-install tools
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
    opts = {
      ensure_installed = {
        -- LSP servers
        "ts_ls",
        "html",
        "cssls",
        "lua_ls",
        "pyright",
        -- Formatters & linters
        "prettier",
        "stylua",
        "ruff",
        "eslint_d",
      },
    },
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach-keymaps", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gR", "<cmd>Telescope lsp_references<CR>", "References")
          map("gd", "<cmd>Telescope lsp_definitions<CR>", "Go to definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("gi", "<cmd>Telescope lsp_implementations<CR>", "Implementations")
          map("gt", "<cmd>Telescope lsp_type_definitions<CR>", "Type definition")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("K", vim.lsp.buf.hover, "Hover docs")
          map("<leader>d", vim.diagnostic.open_float, "Line diagnostics")
          map("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Buffer diagnostics")
          map("<leader>rs", "<cmd>LspRestart<CR>", "Restart LSP")
          map("]d", vim.diagnostic.goto_next, "Next diagnostic")
          map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")

          -- Highlight symbol under cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method("textDocument/documentHighlight") then
            local hl_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = hl_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = hl_group,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(e)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = e.buf })
              end,
            })
          end
        end,
      })

      -- Global capabilities (blink.cmp enhancements for all servers)
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.config("*", { capabilities = capabilities })

      -- Server-specific settings
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            completion = { callSnippet = "Replace" },
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
          },
        },
      })

      -- Install servers and auto-enable them via vim.lsp.enable() (automatic_enable = true by default)
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "html", "cssls", "lua_ls", "pyright" },
      })

    end,
  },
}
