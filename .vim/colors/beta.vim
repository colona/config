" beta (a vim colorscheme configuration file)
" Maintainer:   Matias Larre Borges <m.larreborges@gmail.com>
" Last Change:  2008 Jun 11

" beta -- a simple colorscheme for epita students

" Set background (When set to "dark", Vim will try to use colors that look good
" on a dark background. When set to "light", Vim will try to use colors that
" look good on a light background.)
set background=dark

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

" Colors name
let colors_name = "beta"

" Color the status line everytime
highlight StatusLine term=reverse cterm=bold ctermfg=white ctermbg=Magenta gui=bold guifg=white guibg=blue

if version >= 700
  au BufEnter * hi cursorline term=NONE cterm=underline guibg=NONE
  au InsertEnter * hi StatusLine term=reverse cterm=bold ctermfg=White ctermbg=Magenta  gui=bold guifg=White guibg=Red
  au InsertLeave * hi StatusLine term=reverse cterm=bold ctermfg=White ctermbg=blue     gui=bold guifg=White guibg=Blue
endif 

" TabLine colors:
highlight TabLine term=underline cterm=underline ctermfg=white ctermbg=Blue
highlight TabLineSel term=bold cterm=bold ctermfg=Yellow ctermbg=0
highlight TabLineFill term=underline cterm=underline ctermfg=white ctermbg=Blue

"Completion popup: color settings
highlight   Pmenu               term=NONE cterm=NONE ctermfg=7 ctermbg=5 gui=NONE guifg=Blue guibg=Yellow
highlight   PmenuSel            term=NONE cterm=NONE ctermfg=0 ctermbg=7 gui=NONE guifg=Black guibg=Blue
highlight   PmenuSbar           term=NONE cterm=NONE ctermfg=7 ctermbg=0 gui=NONE guifg=White guibg=Black
highlight   PmenuThumb          term=NONE cterm=NONE ctermfg=0 ctermbg=7 gui=NONE guifg=Black guibg=White 
