" Packages/plugins provided by vim 8.0+ native packaging
" Be sure to run submodule init!
set t_Co=256
set mouse-=a                   " really never want the mouse
set nocompatible               " don't need no vi
set number
set wrap linebreak             " wrap lines, wrap lines on whole words
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
" paste
nnoremap <leader>p :set paste<enter>
" vim-go
nnoremap <leader>r :GoRun<enter>
nnoremap <leader>b :GoBuild<enter>
nnoremap <leader>t :GoTest<enter>
" vim-fugitive
nnoremap <leader>g :Gblame<enter>

" Show tabs and trailing whitespace visually
if (&termencoding == "utf-8") || has("gui_running")
    if v:version >= 700
        set list listchars=tab:»·,trail:·,extends:…,nbsp:‗
    else
        set list listchars=tab:»·,trail:·,extends:…
    endif
else
    if v:version >= 700
        set list listchars=tab:>-,trail:.,extends:>,nbsp:_
    else
        set list listchars=tab:>-,trail:.,extends:>
    endif
endif
