colorscheme dw_green

set nu
syntax on
set tabstop=4
set shiftwidth=4
set expandtab

hi Search term=reverse ctermbg=0 ctermfg=5

noremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

set nobackup
set writebackup
set spellfile=~/.vim/spell/.en.add
set vb t_vb=

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

"noremap <F3> :let gangsign="tex"<CR>
"if gangsign == "tex"
"    map <CR> <ESC>o<TAB>\item
"endif 

" These are needed because for some reason which I cannot
" determine, this system uses non-standard F-Key bindings.
set <F1>=OP
set <F2>=OQ
set <F3>=OR
set <F4>=OS
set <F5>=[15~
set <F6>=[17~
set <F7>=[18~
set <F8>=[19~
set <F9>=[20~
set <S-F9>=[33~
set <F10>=[21~
set <S-F10>=[34~
set <F11>=[23~
set <F12>=[24~

" Programming
    " blocks
map <F9> <ESC>o{<CR>}<ESC>ko
map <S-F9> <ESC>cl<CR>{<CR>}<ESC>k

    " for()
map <F10> oint i=0;<CR>for(i=0;i<n;++i)<CR>{<CR>}<ESC>ko<TAB>

    " if()
map <S-F10> oif()<CR>{<CR>}<ESC>kkllli

    " comments
map <F11> 0i// <ESC> <CR>
map <S-F11> 03x<CR>
map <F12> o/***  ***/<ESC>5ha
map <S-F12> o/*** YOU ARE HERE ***/<ESC>

    " Search
map <C-f> :vim  *.c *.hODODODODODODODOD

" Tabs
map <C-PageDown> :tabn<CR>
map <C-PageUp> :tabp<CR>
map <PageDown> :tabn<CR>
map <PageUp> :tabp<CR>
map <C-j> :wincmd w<CR>
map <C-k> :wincmd W<CR>
map <C-x> 0rx<CR>

" LatexSuite options 
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

