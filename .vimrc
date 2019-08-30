set t_Co=256
set nocompatible               " don't need no vi
set number
execute pathogen#infect()
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


" References
" http://mislav.uniqpath.com/2011/12/vim-revisited/
" get vim-go
" let g:go_fmt_command = "goimports"
"
colorscheme monokai
