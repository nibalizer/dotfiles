"--------------------------------------------------------------------
" Name Of File: dw_green.vim.
" Description: Gvim colorscheme, designed against VIM 7.0 GUI
" By: Steve Cadwallader
" Contact: demwiz@gmail.com
" Credits: Inspiration from the brookstream and redblack schemes.
" Last Change: Saturday, September 17, 2006.
" Installation: Drop this file in your $VIMRUNTIME/colors/ directory.
"--------------------------------------------------------------------

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="dw_green"

"--------------------------------------------------------------------

hi Boolean                                       ctermfg=46
hi cDefine                                       ctermfg=46
hi cInclude                                      ctermfg=255
hi Comment                                       ctermfg=243
hi Constant                                      ctermfg=46
hi Cursor                         ctermbg=237  ctermfg=255
hi CursorColumn                   ctermbg=16
hi CursorLine                     ctermbg=16
hi DiffAdd                        ctermbg=237  ctermfg=46
hi DiffChange                     ctermbg=237  ctermfg=46
hi DiffDelete                     ctermbg=237  ctermfg=46
hi DiffText                       ctermbg=237  ctermfg=255
hi Directory                      ctermbg=00  ctermfg=46
hi ErrorMsg                       ctermbg=255  ctermfg=00
hi FoldColumn                     ctermbg=237  ctermfg=196
hi Folded                         ctermbg=237  ctermfg=196
hi Function                       ctermbg=00  ctermfg=46
hi Identifier                     ctermbg=00  ctermfg=34
hi IncSearch       cterm=NONE       ctermbg=34  ctermfg=00
hi LineNr                         ctermbg=00  ctermfg=28
hi MatchParen      cterm=NONE       ctermbg=237  ctermfg=46
hi ModeMsg                        ctermbg=00  ctermfg=46
hi MoreMsg                        ctermbg=00  ctermfg=46
hi NonText                        ctermbg=00  ctermfg=255
hi Normal          cterm=NONE       ctermbg=00  ctermfg=07
hi Operator        cterm=NONE                      ctermfg=243
hi PreProc         cterm=NONE                      ctermfg=255
hi Question                                      ctermfg=46
hi Search          cterm=NONE       ctermbg=46  ctermfg=00
hi SignColumn                     ctermbg=237  ctermfg=255
hi Special         cterm=NONE       ctermbg=00  ctermfg=255
hi SpecialKey                     ctermbg=00  ctermfg=46
hi Statement       cterm=BOLD                      ctermfg=46
hi StatusLine      cterm=NONE       ctermbg=28  ctermfg=00
hi StatusLineNC    cterm=NONE       ctermbg=237  ctermfg=00
hi String          cterm=NONE                      ctermfg=34
hi TabLine         cterm=NONE       ctermbg=237  ctermfg=00
hi TabLineFill     cterm=underline  ctermbg=00  ctermfg=255
hi TabLineSel      cterm=NONE       ctermbg=46  ctermfg=00
hi Title           cterm=NONE                      ctermfg=46
hi Todo            cterm=NONE       ctermbg=00  ctermfg=196
hi Type            cterm=NONE                      ctermfg=255
hi VertSplit       cterm=NONE       ctermbg=00  ctermfg=255
hi Visual                         ctermbg=46  ctermfg=00
hi WarningMsg                     ctermbg=243  ctermfg=00

"- end of colorscheme -----------------------------------------------  
