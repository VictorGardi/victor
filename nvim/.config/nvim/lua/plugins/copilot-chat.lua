return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = false, -- Enable debugging
      -- Model selection - Available models: gpt-4, gpt-4-turbo, gpt-3.5-turbo, claude-3.5-sonnet, o1-preview, o1-mini
      model = "gpt-4o", -- Default model (can change dynamically)
      -- See Configuration section for rest
      window = {
        layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace'
        width = 0.4, -- 40% of the screen width for the sidebar
        height = 1, -- Full height
        relative = "editor",
      },
      mappings = {
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-r>",
          insert = "<C-r>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        yank_diff = {
          normal = "gy",
        },
        show_diff = {
          normal = "gd",
        },
        show_system_prompt = {
          normal = "gp",
        },
        show_user_selection = {
          normal = "gs",
        },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")

      -- Setup chat with options
      chat.setup(opts)

      -- Custom prompts
      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = "*", range = true })

      -- Inline chat with visual selection
      vim.api.nvim_create_user_command("CopilotChatInline", function(args)
        chat.ask(args.args, {
          selection = select.visual,
          window = {
            layout = "float",
            relative = "cursor",
            width = 1,
            height = 0.4,
            row = 1,
          },
        })
      end, { nargs = "*", range = true })

      -- Quick chat commands
      vim.api.nvim_create_user_command("CopilotChatExplain", function()
        chat.ask("Explain how this code works.", { selection = select.visual })
      end, { range = true })

      vim.api.nvim_create_user_command("CopilotChatReview", function()
        chat.ask("Review this code and suggest improvements.", { selection = select.visual })
      end, { range = true })

      vim.api.nvim_create_user_command("CopilotChatFix", function()
        chat.ask("Fix this code.", { selection = select.visual })
      end, { range = true })

      vim.api.nvim_create_user_command("CopilotChatOptimize", function()
        chat.ask("Optimize this code.", { selection = select.visual })
      end, { range = true })

      vim.api.nvim_create_user_command("CopilotChatDocs", function()
        chat.ask("Add documentation for this code.", { selection = select.visual })
      end, { range = true })

      vim.api.nvim_create_user_command("CopilotChatTests", function()
        chat.ask("Generate tests for this code.", { selection = select.visual })
      end, { range = true })

      vim.api.nvim_create_user_command("CopilotChatFixDiagnostic", function()
        chat.ask("Fix the diagnostic issue in this code.", { selection = select.diagnostics })
      end, { range = true })

      vim.api.nvim_create_user_command("CopilotChatCommit", function()
        chat.ask("Write a commit message for this change.", { selection = select.gitdiff })
      end, {})

      vim.api.nvim_create_user_command("CopilotChatCommitStaged", function()
        chat.ask("Write a commit message for the staged changes.", { selection = select.gitdiff })
      end, {})

      -- Model selection commands
      vim.api.nvim_create_user_command("CopilotChatModel", function(args)
        if args.args ~= "" then
          chat.config.model = args.args
          print("Copilot Chat model set to: " .. args.args)
        else
          print("Current model: " .. chat.config.model)
          print("Available models: gpt-4o, gpt-4, gpt-4-turbo, gpt-3.5-turbo, claude-3.5-sonnet, o1-preview, o1-mini")
        end
      end, { nargs = "?" })

      vim.api.nvim_create_user_command("CopilotChatModels", function()
        print("Available Copilot Chat models:")
        print("  • gpt-4o (default, most capable)")
        print("  • gpt-4 (older, very capable)")
        print("  • gpt-4-turbo (faster GPT-4)")
        print("  • gpt-3.5-turbo (faster, cheaper)")
        print("  • claude-3.5-sonnet (Anthropic)")
        print("  • o1-preview (reasoning model)")
        print("  • o1-mini (smaller reasoning model)")
        print("\nUse :CopilotChatModel <model-name> to switch")
      end, {})
    end,
    event = "VeryLazy",
    keys = {
      -- Quick chat toggle
      { "<leader>ccv", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },

      -- Open chat with prompt
      {
        "<leader>cq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "Quick Chat",
      },

      -- Visual mode commands
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", mode = "x", desc = "Explain Code" },
      { "<leader>cr", "<cmd>CopilotChatReview<cr>", mode = "x", desc = "Review Code" },
      { "<leader>cf", "<cmd>CopilotChatFix<cr>", mode = "x", desc = "Fix Code" },
      { "<leader>co", "<cmd>CopilotChatOptimize<cr>", mode = "x", desc = "Optimize Code" },
      { "<leader>cd", "<cmd>CopilotChatDocs<cr>", mode = "x", desc = "Add Docs" },
      { "<leader>ct", "<cmd>CopilotChatTests<cr>", mode = "x", desc = "Generate Tests" },

      -- Normal mode commands
      { "<leader>cm", "<cmd>CopilotChatCommit<cr>", desc = "Generate Commit Message" },
      { "<leader>cD", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix Diagnostic" },

      -- Model selection
      { "<leader>cM", "<cmd>CopilotChatModels<cr>", desc = "Show Available Models" },
    },
  },
}
