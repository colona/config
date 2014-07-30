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
set nojoinspaces
set switchbuf=useopen
set noeol

" per-project settings
set exrc
set secure

" visual
set background=dark
set synmaxcol=800
set textwidth=80
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
set listchars=tab:▸\ 
colorscheme desert
syntax on
autocmd VimResized * exe "normal! \<c-w>="

" search
set hlsearch
set ignorecase
set noincsearch

" remaps and movements
let mapleader=";"
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
noremap <F2> :silent! :make \| :redraw! \| :botright :cw<cr>
nnoremap <F4> :cp<CR>
nnoremap <F5> :cn<CR>
noremap <F1> <esc>
inoremap <F1> <esc>
" select last insert characters
nnoremap gV `[v`]
" search the current selection
vnoremap * y/<C-r>"<CR>
" add the current word/selection to the last search
nnoremap <Leader>* :execute "/".histget("search", -1).'\\|\<'.expand("<cword>").'\>'<CR>
vnoremap <Leader>* y:execute "/".histget("search", -1).'\\|'.@"<CR>

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

" show trailings and 81+ char lines
highlight ColorColumn ctermbg=red ctermfg=white
function! WrongSpacingsHL()
	if !exists("w:hlspacings")
		let w:hlspacings = 1
	endif
	if w:hlspacings
		let w:m1 = matchadd('ColorColumn', '\s\+$\| \+\ze\t', -1)
		let w:m2 = matchadd('ColorColumn', '\%81v', -1)
	endif
endfunction
function! WrongSpacingsUnHL()
	if w:m1 > 0 && w:m2 > 0
		call matchdelete(w:m1)
		call matchdelete(w:m2)
		let w:m1 = 0
		let w:m2 = 0
	endif
endfunction
nnoremap <F7> :let w:hlspacings = 1<CR>:call WrongSpacingsHL()<CR>
nnoremap <F8> :let w:hlspacings = 0<CR>:call WrongSpacingsUnHL()<CR>
:autocmd WinEnter,BufWinEnter * call WrongSpacingsHL()
:autocmd WinLeave * call WrongSpacingsUnHL()

" hlnext, from Damian Conway
nnoremap <silent> n n:call HLNext(0.4)<cr>
nnoremap <silent> N N:call HLNext(0.4)<cr>
highlight WhiteOnRed ctermbg=red ctermfg=white
function! HLNext (blinktime)
	let [bufnum, lnum, col, off] = getpos('.')
	let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
	let target_pat = '\c\%#'.@/
	let ring = matchadd('WhiteOnRed', target_pat, 101)
	redraw
	exec 'sleep ' . float2nr(a:blinktime * 300) . 'm'
	call matchdelete(ring)
	redraw
endfunction
