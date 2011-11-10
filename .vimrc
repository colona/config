set nocompatible
set background=dark
set textwidth=79
set wrap
set autoindent
set hlsearch
set laststatus=2
set wildmenu
set encoding=utf-8
set fileencoding=utf-8
set scrolloff=3
set pastetoggle=<F3>
set fillchars=""
set nostartofline
set ignorecase
colorscheme desert
behave xterm
syntax on
set statusline=[%n]\ %<%f\ %((%1*%M%*%R%Y)%)\ %=%-19(\Line\ [%4l/%4L]\ \Col\ [%02c%03V]%)\ ascii['%03b']\ %P

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set vi=""

set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" show trailings
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/" containedin=ALL
:match ExtraWhitespace /\s\+$/

" color diff between normal and insert
" set timeoutlen=50
" highlight StatusLine term=reverse cterm=bold ctermfg=white ctermbg=blue gui=bold guifg=white guibg=blue
" if version >= 700
"  au InsertEnter * hi StatusLine term=reverse ctermfg=white ctermbg=magenta
"  au InsertLeave * hi StatusLine term=reverse ctermfg=white ctermbg=blue
" endif

