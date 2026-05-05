---
id: T-001
title: Build grove.nvim task switcher
status: backlog
priority: high
created_at: 2026-05-04
workspace: .dotfiles
---

# Goal

Build grove.nvim — a minimal Neovim plugin that acts as a global task switcher across all repos under `~/git`. The user presses `<leader>gt`, sees all tasks from all repos in a Telescope picker with a live markdown preview, selects a task, and lands in a tmux session running their agent of choice (opencode or claude) in the correct repo directory.

# Context

- Neovim config lives at `nvim/.config/nvim/` inside the dotfiles repo
- Plugin manager: lazy.nvim with per-file specs under `lua/plugins/`
- Telescope is already installed with fzf-native extension (`lua/plugins/telescope.lua`)
- `render-markdown.nvim` is installed and configured (`lua/plugins/markdown.lua`)
- Treesitter has `markdown` + `markdown_inline` parsers installed
- Tasks follow the task-format skill: `.tasks/{backlog,doing,review,done}/T-NNN-slug.md`
- Status is derived from the directory name, not frontmatter
- `~/git` currently contains: `datacreditanalytics-transformations`, `datafinance-transformations`, `datainfra-shared`, `grove`
- No existing grove.nvim code exists anywhere in the dotfiles

## Key design decisions

- Plugin lives inside dotfiles at `nvim/.config/nvim/lua/grove/`
- Status values: `backlog | doing | review | done` (from directory name)
- Parse only `id` + `title` from frontmatter; derive everything else from the filesystem
- Telescope picker with single formatted string entries + right-panel markdown preview
- Preview uses `render-markdown.nvim` (attempt), fallback to treesitter syntax highlight
- Sort order: `doing > review > backlog > done`; `done` hidden by default
- `<C-a>` toggles visibility of `done` tasks
- On select — existing session: `tmux switch-client` immediately
- On select — no session: `vim.ui.select` agent → create session → `tmux send-keys <agent>` → `tmux switch-client`
- Agents: `opencode` and `claude`
- `/` in picker opens function list; selecting `add` → `vim.ui.input` task name → `vim.ui.select` repo → `vim.ui.select` agent → create file + session → switch
- New tasks: status `backlog`, per-repo IDs, full template, `workspace` = repo dir name
- Grove bootstraps `.tasks/{backlog,doing,review,done}/` if directories don't exist
- Auto-refresh scan on every picker open
- Configuration: `setup({ git_dir = "~/git" })` only

# Implementation Plan

1. Create `lua/grove/config.lua` — default config table with `git_dir`
2. Create `lua/grove/tasks.lua` — scan repos, parse frontmatter, sort by status priority
3. Create `lua/grove/tmux.lua` — session check / create / send-keys / switch
4. Create `lua/grove/template.lua` — ID generation, slugify, dir bootstrap, file write
5. Create `lua/grove/picker.lua` — Telescope picker, markdown previewer, function mode
6. Create `lua/grove/init.lua` — public API: `setup()` + `tasks()`
7. Create `lua/plugins/grove.lua` — lazy.nvim spec + `<leader>gt` keymap

# Definition of Done

- [ ] `lua/grove/config.lua` exists with default `git_dir = ~/git`
- [ ] `lua/grove/tasks.lua` scans repos, parses id+title from frontmatter, derives status from directory name
- [ ] `lua/grove/tmux.lua` can check, create, and switch tmux sessions with correct cwd
- [ ] `lua/grove/template.lua` generates per-repo sequential IDs, slugifies titles, writes full task template, bootstraps `.tasks/` directories
- [ ] `lua/grove/picker.lua` opens Telescope with formatted single-string entries and markdown preview
- [ ] Preview renders with `render-markdown.nvim` (headings, checkboxes, code blocks visible)
- [ ] `<C-a>` toggles done tasks
- [ ] `/` key opens function picker; `add` flow completes without error
- [ ] `lua/grove/init.lua` exposes clean `setup()` and `tasks()` API
- [ ] `lua/plugins/grove.lua` spec loads cleanly with lazy.nvim; `<leader>gt` is registered
- [ ] Selecting a task with no session prompts for agent, creates tmux session, sends agent command, switches
- [ ] Selecting a task with existing session switches immediately with no prompt
- [ ] New task file created by grove passes task-format skill schema validation
- [ ] No errors in `:messages` during normal picker usage

# Risks

- `render-markdown.nvim` may not attach to Telescope preview buffers due to `buftype=nofile` guard — handle with explicit `pcall(rm.enable)` after setting filetype
- `tmux switch-client` only works inside an active tmux session; guard with `vim.fn.exists("$TMUX")` check and show a warning if not in tmux
- Telescope preview buffer is reused across selections — clear lines before setting new ones in `define_preview`
- `vim.ui.select` must only be called after `actions.close(prompt_bufnr)` — use `vim.schedule` to defer
- Per-repo ID scanning reads all task filenames on each `/add` — wrap in `pcall` for permission errors

# Notes

Generated via plan-task
