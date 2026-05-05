call plug#begin('~/.vim/plugged')
Plug 'https://github.com/gruvbox-community/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" markdown plugins
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'pwntester/octo.nvim'

" Telescope requirements"
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim',  { 'do': 'make' }

" Harpoon
Plug 'ThePrimeagen/harpoon'

" Vim-be-good game
Plug 'ThePrimeagen/vim-be-good'

" tab icons
Plug 'nvim-tree/nvim-web-devicons'

" gitsigns
Plug 'lewis6991/gitsigns.nvim'

" Plug 'sainnhe/everforest'
" Plug 'rose-pine/neovim'

Plug 'sainnhe/everforest'

" tokyonight theme
" Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
call plug#end()
" see :help evernote.txt for this section
" Important!!
if has('termguicolors')
  set termguicolors
endif

" For dark version.
set background=dark

" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'soft'

" For better performance
let g:everforest_better_performance = 1

let g:everforest_transparent_background = 1
colorscheme everforest
" colorscheme tokyonight-moon
" set background=dark

" config octo
lua require("octo").setup()

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
