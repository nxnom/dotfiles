if has("nvim")
    let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'cohama/lexima.vim'

if has("nvim")
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'windwp/nvim-autopairs'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'glepnir/lspsaga.nvim'

    " completion
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'onsails/lspkind-nvim'
endif

call plug#end()
