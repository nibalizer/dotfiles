" Packages/plugins provided by vim 8.0+ native packaging
" Be sure to run submodule init!
set t_Co=256
set nocompatible               " don't need no vi
set number
syntax on
filetype plugin indent on
set ts=4
set expandtab
set sw=4
set backspace=indent,eol,start  " backspace through everything in insert mode
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set showcmd                     " show what's in flight at the bottom
let mapleader = "-"             " set leaderkey to -


" References
" http://mislav.uniqpath.com/2011/12/vim-revisited/
" get vim-go
" let g:go_fmt_command = "goimports"
"
colorscheme monokai

nnoremap <leader>r :GoRun<enter>
nnoremap <leader>b :GoBuild<enter>
