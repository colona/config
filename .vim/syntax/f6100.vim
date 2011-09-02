""
"" f6100.vim for corewar-syntax in /u/a1/sigour_b/.vim/syntax
""
"" Made by SIGOURE Benoit
"" Login   <sigour_b@epita.fr>
""
"" Started on  Fri Nov 25 12:26:13 2005 SIGOURE Benoit
"" Last update Wed Nov 30 04:24:09 2005 SIGOURE Benoit
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
syn match	f6100Directive		"\.name"
syn match	f6100Directive		"\.comment"

" Keywords: {{{1
" =========
syn keyword	f6100Conditional	b bz bnz bs
syn match       f6100Register           "r[0-9]\+"
syn match	f6100Special		display contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"
syn region	f6100String		start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=f6100Special,@Spell
syn match	f6100Character		"L\='[^\\]'"
syn match	f6100Character		"L'[^']*'" contains=f6100Special
syn match	f6100SpecialCharacter	display "L\='\\\o\{1,3}'"
syn match	f6100SpecialCharacter	display "'\\x\x\{1,2}'"
syn match	f6100SpecialCharacter	display "L'\\x\x\+'"
syn match	f6100Label		"[A-Za-z][A-Za-z0-9_]*:"
syn keyword	f6100ArithOp		and or xor not rol asr add[i] sub cmp[i] neg mov swp
syn keyword	f6100MemOp		lc ll ldr str ldb stb
syn keyword	f6100SpecialOp		write stat mode fork crash nop
syn keyword	f6100SpecialOp2		check

" Numbers: {{{1
" ========

"integer number, or floating point number without a dot and with "f".
syn match	f6100Numbers		display transparent "\<\d\|\.\d" contains=f6100Number,f6100Float,f6100Octal
" Same, but without octal error (for comments)
syn match	f6100NumbersCom		display contained transparent "\<\d\|\.\d" contains=f6100Number,f6100Float,f6100Octal
syn match	f6100Number		display contained "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
"hex number
syn match	f6100Number		display contained "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"
" Flag the first zero of an octal number as something special
syn match	f6100Octal		display contained "0\o\+\(u\=l\{0,2}\|ll\=u\)\>" contains=f6100OctalZero
syn match	f6100OctalZero		display contained "\<0"
syn match	f6100Float		display contained "\d\+f"
"floating point number, with dot, optional exponent
syn match	f6100Float		display contained "\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\="
"floating point number, starting with a dot, optional exponent
syn match	f6100Float		display contained "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
"floating point number, without dot, with exponent
syn match	f6100Float		display contained "\d\+e[-+]\=\d\+[fl]\=\>"
"hexadecimal floating point number, optional leading digits, with dot, with exponent
syn match	f6100Float		display contained "0x\x*\.\x\+p[-+]\=\d\+[fl]\=\>"
"hexadecimal floating point number, with leading digits, optional dot, with exponent
syn match	f6100Float		display contained "0x\x\+\.\=p[-+]\=\d\+[fl]\=\>"

" Constants: {{{1
" ==========
syn match	f6100Constant		"\.data"
syn match	f6100Constant		"\.rodata"
syn match	f6100Constant		"\.text"
syn match	f6100Constant		"\.bss"

" Comments: {{{1
" =========
syn cluster	f6100CommentGroup	contains=f6100Todo,@Spell
syn keyword	f6100Todo		contained TODO FIXME NOTE WARNING
syn match	f6100Comment		"#.*$" contains=@f6100CommentGroup

" Default Highlighting: {{{1
" =====================
hi def link	f6100Todo		Todo
hi def link	f6100Comment		Comment
hi def link	f6100Loop		f6100Statement

hi def link	f6100Constant		Constant
hi def link	f6100Register		Macro
hi def link	f6100Conditional	Conditional
hi def link	f6100String		String
hi def link	f6100Character		Character
hi def link	f6100SpecialCharacter	Special
hi def link	f6100Special		SpecialChar
hi def link	f6100Directive		PreProc
hi def link	f6100Number		Number
hi def link	f6100Float		Float
hi def link	f6100Octal		Number
hi def link	f6100Label		Label
hi def link	f6100ArithOp		Type
hi def link	f6100MemOp		Type
hi def link	f6100SpecialOp		Special
hi def link	f6100SpecialOp2		Type
