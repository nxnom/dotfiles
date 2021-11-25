if has("nvim")
    let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'cohama/lexima.vim'
Plug 'vim-airline/vim-airline'

if has("nvim")
"    Plug 'windwp/nvim-autopairs'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'

    " NerdTree
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'

    Plug 'preservim/nerdcommenter'

    " LSP
"    Plug 'neovim/nvim-lspconfig'
"    Plug 'glepnir/lspsaga.nvim'

    " completion
"   Plug 'hrsh7th/cmp-nvim-lsp'
"   Plug 'hrsh7th/cmp-buffer'
"   Plug 'hrsh7th/cmp-path'
"   Plug 'hrsh7th/cmp-cmdline'
"   Plug 'hrsh7th/nvim-cmp'
"   Plug 'onsails/lspkind-nvim'

    " Prettier ??
"    Plug 'w0rp/ale'
endif

let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

let g:ale_fix_on_save = 1

call plug#end()
