# Neovim Keybindings

Leader key: `<Space>`

## General

| Key | Action |
|-----|--------|
| `jk` (insert) | Exit insert mode |
| `<leader>nh` | Clear search highlights |
| `<leader>rr` | Toggle reading mode (wrap, no numbers, spell) |

## Window Management

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate windows |
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |
| `<leader>se` / `<leader>=` | Equal split sizes |
| `<leader>sx` | Close split |
| `<C-Up/Down>` | Resize height |
| `<C-Left/Right>` | Resize width |

## Tabs

| Key | Action |
|-----|--------|
| `<leader>tn` | Next tab |
| `<leader>tp` | Previous tab |
| `<leader>tx` | Close tab |
| `<leader>tf` | Open buffer in new tab |

## Terminal

| Key | Action |
|-----|--------|
| `<C-\>` / `<leader>j` | Toggle terminal |
| `<Esc><Esc>` (terminal) | Exit terminal mode |

## File Explorer (Snacks)

| Key | Action |
|-----|--------|
| `<C-b>` / `<leader>ee` | Toggle explorer |
| `<leader>ef` | Focus explorer |

## Find (Telescope)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fG` | Git files |
| `<leader>fr` | Recent files |
| `<leader>fc` | Find word under cursor |
| `<leader>fl` | Find TODOs |
| `<leader>fb` | Open buffers |
| `<leader>fh` | Help tags |

## LSP

| Key | Action |
|-----|--------|
| `gR` | References |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Implementations |
| `gt` | Type definition |
| `K` | Hover docs |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>d` | Line diagnostics (float) |
| `<leader>D` | Buffer diagnostics (Telescope) |
| `<leader>rs` | Restart LSP |
| `]d` / `[d` | Next / prev diagnostic |

## Git (Gitsigns)

| Key | Action |
|-----|--------|
| `]h` / `[h` | Next / prev hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hR` | Reset buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line (full) |
| `<leader>hB` | Toggle blame line |
| `<leader>hd` | Diff this |
| `<leader>hD` | Diff this (cached) |

## Git (Fugitive)

| Key | Action |
|-----|--------|
| `<leader>gs` / `<leader>rg` | Git status (`:G`) |
| `<leader>gb` | Git blame |
| `<leader>gd` / `<leader>rd` | Git diff |

## Review (Diffview + Telescope)

| Key | Action |
|-----|--------|
| `<leader>rv` | Open Diffview |
| `<leader>rq` | Close Diffview |
| `<leader>rh` | File history (Diffview) |
| `<leader>rH` | Repo history (Diffview) |
| `<leader>rc` | File commits (Telescope) |
| `<leader>rC` | Repo commits (Telescope) |
| `<leader>rp` | Preview hunk |
| `<leader>rb` | Blame line |

## Diagnostics / Trouble

| Key | Action |
|-----|--------|
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Buffer diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |
| `<leader>xt` | TODOs |
| `<leader>l` | Trigger linting |

## TODO Comments

| Key | Action |
|-----|--------|
| `]t` / `[t` | Next / prev TODO |

## Treesitter Text Objects

| Key | Action |
|-----|--------|
| `af` / `if` | Outer / inner function |
| `ac` / `ic` | Outer / inner class |
| `aa` / `ia` | Outer / inner parameter |
| `]f` / `[f` | Next / prev function start |
| `]c` / `[c` | Next / prev class start |
| `<leader>sn` / `<leader>sp` | Swap parameter next / prev |

## Markdown

| Key | Action |
|-----|--------|
| `<leader>mt` | Toggle render-markdown |
| `<leader>mb` | Toggle browser preview |
| `<leader>mf` | Format file |

## Completion (blink.cmp)

| Key | Action |
|-----|--------|
| `<Tab>` | Next item / expand snippet |
| `<S-Tab>` | Previous item / prev snippet stop |
| `<CR>` | Accept completion |
| `<C-Space>` | Show/hide completion menu |
| `<C-e>` | Hide completion menu |
| `<C-d>` / `<C-u>` | Scroll docs down / up |
