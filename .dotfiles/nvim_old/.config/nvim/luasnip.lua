if vim.g.snippets ~= "luasnip" then
    return
end

local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside of the selection
    history = true,

    -- Update dynamic snippets as you type
    updateevents = "TextChanged,TextChangedI",

    -- Autosnippets:
    enable_autosnippets = true,

    -- Crazy highlights!!
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "<--", "Error" }},
            },
        },
    },
}

-- keymaps for lua snips
-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

-- <c-j> jump backwards key e.g. move to previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

-- <c-l> selection within a list of options
vim.keymap.set( "i", "<c-l>", function()
    if ls.choice_active() then
        ls.choice_active(1)
    end
end)

-- shortcut to source luasnips file
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/luasnip.lua<CR>")


-- snippets
-- ls.parser.parse_snippet(<text>, <VS-Code style snippet>)
ls.snippets = {
    all = {
        -- Available in any filetype
        ls.parser.parse_snippet("expand", "-- this is what was expanded!")
    },

    lua = {
        -- lua specific snippet go here...
        ls.parser.parse_snippet("lf", "local $1 = function($2)\n $0\nend"),
    },
}
