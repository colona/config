" general
set nocompatible
set noswapfile
set showmode
set showcmd
set encoding=utf-8
set fileencoding=utf-8
set vi=""
set mouse=
behave xterm
set title
set noerrorbells
set novisualbell

" visual
set background=dark
set textwidth=79
set wrap
set linebreak
set laststatus=2
set hidden
set scrolloff=3
set wildmenu
set wildmode=longest:full
set fillchars=""
set statusline=[%n]\ %<%f
set statusline+=\ %((%1*%M%*%R%Y,%{&ff},%{strlen(&fenc)?&fenc:&enc})%)\ %=
set statusline+=%-19(\Line\ [%4l/%4L]\ \Col\ [%02c%03V]%)\ ascii['%03b']\ %P
colorscheme desert
syntax on
au VimResized * exe "normal! \<c-w>="

" search
set hlsearch
set ignorecase
set noincsearch

" remaps and movements
set pastetoggle=<F3>
set nostartofline
nnoremap <Left> <C-w>h
nnoremap <Down> <C-w>j
nnoremap <Up> <C-w>k
nnoremap <Right> <C-w>l
nnoremap <C-Left> :bp<CR>
nnoremap <C-Right> :bn<CR>
map <F1> :make<CR>

" indentation
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd filetype make set noexpandtab
set autoindent

" backup
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
silent !mkdir -p ~/.vimtmp/backup
silent !mkdir -p ~/.vimtmp/temp

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

" << That stupid goddamned help key that you will invaribly hit constantly
" while aiming for escape >> -- Steve Losh
inoremap <F1> <esc>
vnoremap <F1> <esc>
nnoremap <F1> <esc>

" show trailings and 80+ char lines
":highlight ExtraWhitespace ctermbg=red guibg=red
":match ExtraWhitespace /\s\+$\| \+\ze\t/
:au BufWinEnter * let w:m1=matchadd('ErrorMsg', '\s\+$\| \+\ze\t', -1)
:au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)

" from delroth configuration for automatic Epita guards
function Epita_c_insert_guards()
    let basename=substitute(@%, "[^/]*/", "", "g")
    let underscored=tr(basename, ".", "_")
    let const=substitute(underscored, ".*", "\\U\\0", "")."_"
    exe "normal i#ifndef ".const."\n\e"
    exe "normal i# define ".const."\n\n\n\n\e"
    exe "normal i#endif /"."* !".const." */\e"
    exe "normal 4G"
endfunction

if $EPITA == 1
    au Bufnewfile,Bufread *.h set ft=c
    au Bufnewfile *.h call Epita_c_insert_guards()
endif

function Epita_cpp_insert_guards()
    let basename=substitute(@%, "[^/]*/", "", "g")
    let underscored=substitute(basename, "[^a-zA-Z_]", "_", "g")
    let const=substitute(underscored, ".*", "\\U\\0", "")."_"
    exe "normal i#ifndef ".const."\n\e"
    exe "normal i# define ".const."\n\n\n\n\e"
    exe "normal i#endif // !".const."\e"
    exe "normal 4G"
endfunction

if $EPITA == 1
    au Bufnewfile,Bufread *.hh set ft=cpp
    au Bufnewfile *.hh call Epita_cpp_insert_guards()
endif
