-- Disable fzf-lua keymaps (we use telescope instead)
return {
  "ibhagwan/fzf-lua",
  enabled = true, -- Keep enabled for avante, but no keymaps
  keys = {}, -- No keymaps for fzf-lua
  opts = {},
}
