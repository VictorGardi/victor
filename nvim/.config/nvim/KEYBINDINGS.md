# Custom Keybindings Summary

## New Keybindings Added

### File Tree (NvimTree)
- **`Ctrl+b`** - Toggle file explorer sidebar
- `<leader>ee` - Toggle file explorer (alternative)
- `<leader>ef` - Toggle file explorer on current file
- `<leader>ec` - Collapse file explorer
- `<leader>er` - Refresh file explorer

### Avante AI Assistant
- **`Ctrl+r`** - Open Avante AI chat (works in normal and visual mode)
- In Avante diff view:
  - `a` - Apply change at cursor
  - `A` - Apply all changes
  - `co` - Choose "ours" (keep your code)
  - `ct` - Choose "theirs" (accept AI suggestion)
  - `]x` / `[x` - Navigate between changes

### Terminal
- **`Ctrl+\`** - Toggle integrated terminal (backslash key)
- `<leader>j` - Toggle terminal (alternative)

### Git (Fugitive)
- **`:G blame`** - Show git blame for current file
- `<leader>gb` - Git blame (keymap shortcut)
- `<leader>gd` - Git diff
- `<leader>gs` - Git status
- Other `:G` commands available (`:Gdiffsplit`, `:Gread`, `:Gwrite`, etc.)

### Telescope (File Finding)
- `<leader>ff` - Find files in current directory
- `<leader>fg` - Live grep (search text in files) ✅ FIXED
- `<leader>fG` - Find git-tracked files only
- `<leader>fr` - Find recent files
- `<leader>fc` - Find string under cursor
- `<leader>fl` - Find todos

## Quick Reference
- **`Ctrl+b`** → File tree
- **`Ctrl+r`** → AI assistant
- **`Ctrl+\`** → Terminal
- **`<leader>gb`** → Git blame

## Window Management & Resizing

### Mouse Support
- **Drag window borders** with mouse to resize
- **Click window borders** to select and resize
- Mouse is enabled in all modes

### Keyboard Resizing (Easy!)
- **`Shift+Up`** - Increase window height
- **`Shift+Down`** - Decrease window height
- **`Shift+Left`** - Decrease window width
- **`Shift+Right`** - Increase window width
- **`<leader>=`** (Space then =) - Make all windows equal size

### Alternative: Ctrl + Arrow Keys
- `Ctrl+Up/Down/Left/Right` - Same as Shift+arrows

### Window Splits
- `<leader>sv` - Split window vertically
- `<leader>sh` - Split window horizontally
- `<leader>sx` - Close current split
- `Ctrl+w =` - Make all splits equal size (manual command)

## Plugins Installed
- ✅ vim-fugitive - Git integration
- ✅ nvim-tree - File explorer
- ✅ avante.nvim - AI assistant
- ✅ telescope.nvim - Fuzzy finder

## Usage
1. **Restart Neovim** to load all new keybindings and plugins
2. Run `:Lazy sync` if plugins need to be installed
3. Try out your new keybindings!
