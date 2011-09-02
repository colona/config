set nocompatible
set background=dark
set textwidth=78
set autoindent
set backspace=indent,eol,start
set whichwrap=b,s,l,h,<,>,[,]
set hlsearch
set laststatus=2
set statusline=[%n]\ %<%f\ %((%1*%M%*%R%Y)%)\ %=%-19(\Line\ [%4l/%4L]\ \Col\ [%02c%03V]%)\ ascii['%03b']\ %P
set wildmenu
"set shiftwidth=2
syntax enable						" Syntax coloration
filetype on						" Enable filetype recognition
filetype indent off
filetype plugin on
behave xterm
set encoding=utf-8
set fileencoding=utf-8
set scrolloff=3
set nostartofline
set ignorecase

set noexpandtab
set tabstop=4
" set softtabstop=4
" set shiftwidth=4
set pastetoggle=<F3>
set fillchars=""
set timeoutlen=50

highlight WhitespaceEOL ctermbg=red
match WhitespaceEOL /\s\+$/							" Show trailing whitespaces
autocmd BufWrite *.c,*.h,*.sh silent! %s/[\r \t]\+$//				" automatically delete trailing whitespace

" Keyboard special actions
map <F1> :make<CR>								" F1 = compile

" Color the status line everytime
highlight StatusLine term=reverse cterm=bold ctermfg=white ctermbg=blue gui=bold guifg=white guibg=blue
" Switch color from blue to pink when changing modes
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermfg=white ctermbg=magenta
  au InsertLeave * hi StatusLine term=reverse ctermfg=white ctermbg=blue
endif
" Underline the current line in other buffers
autocmd BufEnter * setlocal nocursorline
autocmd BufLeave * setlocal cursorline
hi cursorline ctermbg=none guibg=gray70

