" general
set nocompatible
set noswapfile
set showmode
set showcmd
set hidden
set encoding=utf-8
set fileencoding=utf-8
set vi=""
set mouse=
behave xterm
set title
set noerrorbells
set novisualbell

" per-project settings
set exrc
set secure

" visual
set background=dark
set synmaxcol=800
set textwidth=79
set wrap
set linebreak
set laststatus=2
set scrolloff=3
set wildmenu
set wildmode=longest:full
set fillchars=""
set statusline=[%n]\ %<%f
set statusline+=\ %((%1*%M%*%R%Y,%{&ff},%{strlen(&fenc)?&fenc:&enc})%)\ %=
set statusline+=%-19(\Line\ [%4l/%4L]\ \Col\ [%02c%03V]%)\ ascii['%03b']\ %P
colorscheme desert
syntax on
autocmd VimResized * exe "normal! \<c-w>="

" search
set hlsearch
set ignorecase
set noincsearch

" remaps and movements
set pastetoggle=<F3>
set nostartofline
noremap j gj
noremap k gk
noremap gj j
noremap gk k
nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l
nnoremap <S-Left> :bp<CR>
nnoremap <S-Right> :bn<CR>
noremap <F2> :make<CR>
nnoremap <F4> :cp<CR>
nnoremap <F5> :cn<CR>
noremap <F1> <esc>
inoremap <F1> <esc>

" xterm-style keys sent from tmux : C-arrows
if &term =~ '^screen'
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
endif

" indentation
set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd filetype make set noexpandtab
set autoindent

" backup
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
silent !mkdir -p ~/.vim/backup
silent !mkdir -p ~/.vim/temp

" folds
set foldlevelstart=0
set foldmethod=marker
set foldmarker={,}
function! MyFoldText()
	let start = getline(v:foldstart)
	let end = getline(v:foldend)
	let nstart = v:foldstart + 1
	let nend = v:foldend - 1
	let lcount = len(filter(getline(nstart, nend), '!empty(v:val)'))
	return start . ' ... ' . lcount . ' lines ... ' . end
endfunction
set foldtext=MyFoldText()

" show trailings and 80+ char lines
":highlight ExtraWhitespace ctermbg=red guibg=red
":match ExtraWhitespace /\s\+$\| \+\ze\t/
":au BufWinEnter * let w:m1=matchadd('ErrorMsg', '\s\+$\| \+\ze\t', -1)
":au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)
function WrongSpacingsHL()
    call matchadd('ErrorMsg', '\s\+$\| \+\ze\t', -1)
    call matchadd('ErrorMsg', '\%>79v.\+', -1)
endfunction
nnoremap <F7> :call WrongSpacingsHL()<CR>
nnoremap <F8> :call clearmatches()<CR>
:autocmd BufWinEnter * call WrongSpacingsHL()
