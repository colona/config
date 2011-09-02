""
"" testlist.vim for vim-syntax in /u/a1/sigour_b/.vim/syntax
""
"" Made by SIGOURE Benoit
"" Login   <sigour_b@epita.fr>
""
"" Started on  Sun Jan  8 05:58:18 2006 SIGOURE Benoit
"" Last update Sun Jan  8 09:37:08 2006 SIGOURE Benoit
""

" For version 5.x: Clear all syntax items {{{1
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Directives: {{{1
" ======
syn match	tlistDirective "^%\w\+\>"
syn match	tlistNumber	"-\=\<\d\+\>"

" Comments: {{{1
" =========
syn cluster    tlistCommentGroup	contains=tlistTodo,@Spell
syn keyword    tlistTodo	contained	TODO FIXME XXX NOTE[S]
syn match      tlistComment	"#.*$" contains=@tlistCommentGroup

" Strings: {{{1
" ========
syn match	tlistSpecial		display contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"
syn region	tlistString		start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=tlistSpecial,Spell

hi def link	tlistDirective		Keyword
hi def link	tlistComment		Comment
hi def link	tlistNumber		Number
hi def link	tlistString		String
hi def link	tlistSpecial		SpecialChar

let b:current_syntax = "testlist"
