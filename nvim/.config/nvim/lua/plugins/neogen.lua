return {
  "danymat/neogen",
  enabled = false, -- Disabled - enable if you need docstring generation
  config = function()
    require("neogen").setup({
      languages = {
        python = {
          template = { annotation_convention = "numpydoc" },
        },
      },
      enabled = true, --if you want to disable Neogen
      input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
    })
    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    local opts = { noremap = true, silent = true, desc = "Generate docstring for func" }
    keymap.set("n", "<Leader>nn", ":lua require('neogen').generate()<cr>", opts)
    keymap.set("n", "<Leader>nc", ":lua require('neogen').generate( {type = 'class' })<cr>", opts)
  end,
}
