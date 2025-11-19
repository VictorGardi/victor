# Copilot Setup Guide

## Authentication

### First Time Setup
1. Open Neovim
2. Run `:Copilot auth`
3. Follow the browser prompts to authenticate with GitHub
4. Return to Neovim - you're authenticated!

### Check Authentication Status
- Run `:Copilot status` to check if you're authenticated
- If not authenticated, run `:Copilot auth` again

### Sign Out
- Run `:Copilot signout` to sign out

## Model Selection

### Available Models
- **gpt-4o** (default) - Most capable, latest model
- **gpt-4** - Very capable, older version
- **gpt-4-turbo** - Faster GPT-4
- **gpt-3.5-turbo** - Faster and cheaper
- **claude-3.5-sonnet** - Anthropic's Claude
- **o1-preview** - OpenAI's reasoning model (slower, better for complex problems)
- **o1-mini** - Smaller reasoning model

### How to Select a Model

#### View Available Models
```vim
:CopilotChatModels
```
Or press `<leader>cM`

#### View Current Model
```vim
:CopilotChatModel
```

#### Switch Model
```vim
:CopilotChatModel gpt-4o
:CopilotChatModel claude-3.5-sonnet
:CopilotChatModel o1-preview
```

### Model Recommendations

- **General coding**: `gpt-4o` (default)
- **Complex problems/reasoning**: `o1-preview` or `o1-mini`
- **Quick responses**: `gpt-3.5-turbo` or `gpt-4-turbo`
- **Alternative perspective**: `claude-3.5-sonnet`

## Quick Reference

### Ghost Text Suggestions
- `<Tab>` - Accept suggestion
- `Alt+]` - Next suggestion
- `Alt+[` - Previous suggestion
- `Ctrl+]` - Dismiss suggestion

### Chat Commands
- `<leader>cc` - Toggle chat
- `<leader>cq` - Quick chat
- `<leader>cM` - Show available models

### Visual Mode (select code first)
- `<leader>ce` - Explain
- `<leader>cr` - Review
- `<leader>cf` - Fix
- `<leader>co` - Optimize
- `<leader>cd` - Add docs
- `<leader>ct` - Generate tests

### Authentication Commands
- `:Copilot auth` - Authenticate
- `:Copilot status` - Check status
- `:Copilot signout` - Sign out

## Troubleshooting

### Not Getting Suggestions?
1. Check authentication: `:Copilot status`
2. If not authenticated: `:Copilot auth`
3. Restart Neovim

### Chat Not Working?
1. Make sure you're authenticated: `:Copilot status`
2. Check if the plugin loaded: `:Lazy`
3. Try switching models: `:CopilotChatModel gpt-4o`

### Want to Disable Temporarily?
- `:Copilot disable` - Disable suggestions
- `:Copilot enable` - Re-enable suggestions
