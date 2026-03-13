return {
  "nvim-mini/mini.indentscope",
  version = false,
  event = { "BufReadPre", "BufNewFile" },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "help", "alpha", "dashboard", "NvimTree", "neo-tree",
        "Trouble", "trouble", "lazy", "mason", "notify",
        "toggleterm", "lazyterm", "TelescopePrompt",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
  config = function()
    local indentscope = require("mini.indentscope")
    indentscope.setup({
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        delay = 100,
        animation = indentscope.gen_animation.none(),
      },
    })
  end,
}
