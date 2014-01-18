"#http://mislav.uniqpath.com/2011/12/vim-revisited/

set nocompatible                " choose no compatibility with legacy vi
syntax enable
colorscheme desert
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
set number

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter



" Make sure that there is a corresponding 'stty erase ^?'
" in the .zshlocal file
let osys=system('uname -s')
if osys == "FreeBSD"
  set t_kb=
  fixdel
elseif osys == "Linux"
  set t_kb=
  fixdel
endif

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



