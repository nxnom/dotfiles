set exrc
set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set number
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set sidescrolloff=12
set noshowmode
"set completeopt=menuone,noinsert,noselect
set colorcolumn=80
set signcolumn=yes
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
" use system clipboard
set clipboard=unnamed

set updatetime=50
set shortmess+=c

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" plugins
runtime ./plug.vim

" Keymaps
runtime ./maps.vim

colorscheme NeoSolarized
highlight Normal guibg=none

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup MY_AUTO_COMMANDS
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Start Variables ---
" Show hidden files (dotfiles) in NERDTree Plugin
let NERDTreeShowHidden=1

" Airline Theme Setting
let g:airline_theme='selenized'

let g:NERDTreeIgnore = ['^node_modules$','.git$','.vscode']

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-flutter',
  \ 'coc-emmet',
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-json',
  \ ]

let g:dart_format_onsave = 1
let g:dartfmt_options = ['--fix','--line-length 120']
