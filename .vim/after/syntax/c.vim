""
"" c.vim for vim in /u/a1/sigour_b/.vim/after/syntax/c.vim
""
"" Made by SIGOURE Benoit
"" Login   <sigour_b@epita.fr>
""
"" Started on  Tue Nov 22 04:28:04 2005 SIGOURE Benoit
"" Last update Fri Oct  6 16:31:46 2006 SIGOURE Benoit
""

syn keyword	cTodo			contained NOTE[S] WARNING BUG[S] DEBUG
if !exists("c_no_c99")
  syn keyword cConstant __VA_ARGS__
endif

" This adds some extra conversion modifiers for string formats which are not
" supported by the default highlighting patterns:
"  - C99: `hh', `t', `z', `j'
"  - BSD: `q'
"  - GNU `Z' (deprecated)
" See http://www.gnu.org/software/libc/manual/html_node/Integer-Conversions.html
syn match	cFormat		display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hjlLtzZ]\|ll\|hh\)\=\([bdiuoxXDOUfeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained

syn match	eCSS_80columns		".\{80,}"
syn match	eCSS_parentheses_braces	excludenl ") {"
syn match	eCSS_double_semicolon	";;"
syn match	eCSS_comma		",[^ \t]\+"
" FIXME: THe following doesn't highlight anything :(
"syn match	eCSS_space_after_kw	"\(if\|for\|while\|switch\|sizeof\)[^a-zA-Z0-9_ ]"
syn match	eCSS_return_void	"\(return\)\@<= \+;"
" FIXME: the following doesn't highlight properly the invalid extra spaces
syn match	eCSS_return_spaces	"\(return\)\@<=  \+("
syn match	eCSS_return_spaces	"\(return\)\@<=("
" FIXME:
"syn match	eCSS_spaces_binops	"\(\*\|==\?\|&&\?\|||\?\|<<\|>>\|<=\|>=\|+=\|-=\|%\)[^ ]"
"syn match	eCSS_spaces_binops	"[^ ]\(\*\|==\?\|&&\?\|||\?\|<<\|>>\|<=\|>=\|+=\|-=\|%\)"
"syn match	eCSS_spaces_binops	"+[^ +;]"
"syn match	eCSS_spaces_binops	"-[^ ->;]"
" FIXME:
"syn match	eCSS_spaces_binops	"[^ -]>"
"syn match	eCSS_spaces_binops	"[^ /]*"
"syn match	eCSS_spaces_binops	"/[^ /*]"
"syn match	eCSS_space_before_coma	"[^ ];"

hi link		eCSS_80columns			Error
hi link		eCSS_parentheses_braces		Error
hi link		eCSS_double_semicolon		Error
hi link		eCSS_comma			Error
hi link		eCSS_space_after_kw		Error
hi link		eCSS_return_void		Error
"hi link		eCSS_spaces_binops		Error

source $HOME/.vim/syntax/doxygen.vim
