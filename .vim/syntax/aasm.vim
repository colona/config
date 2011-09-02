""
"" aasm.vim for aasm-syntax in /u/a1/sigour_b/.vim/syntax
""
"" Made by SIGOURE Benoit
"" Login   <sigour_b@epita.fr>
""
"" Started on  Fri Nov 25 12:26:13 2005 SIGOURE Benoit
"" Last update Fri Nov 25 20:36:36 2005 SIGOURE Benoit
""

" For version 5.x: Clear all syntax items {{{1
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Types: {{{1
" ======
syn match	aasmType "\.long"
syn match	aasmType "\.ascii"
syn match	aasmType "\.asciz"
syn match	aasmType "\.byte"
syn match	aasmType "\.double"
syn match	aasmType "\.float"
syn match	aasmType "\.hword"
syn match	aasmType "\.int"
syn match	aasmType "\.octa"
syn match	aasmType "\.quad"
syn match	aasmType "\.short"
syn match	aasmType "\.single"
syn match	aasmType "\.space"
syn match	aasmType "\.string"
syn match	aasmType "\.word"

" Keywords: {{{1
" =========
syn match	aasmKeyword		"\.mod_load"
syn match	aasmKeyword		"\.section"
syn match	aasmKeyword		"\.ends"
syn match	aasmKeyword		"\.export"
syn match	aasmKeyword		"\.extern"
syn match	aasmKeyword		"\.section_align"
syn match	aasmKeyword		"\.mod_asm"
syn match	aasmInclude		"\.include"
syn match	aasmInclude		"\.define"
syn match	aasmInclude		"\.macro"
syn match	aasmInclude		"\.endm"
syn match	aasmInclude		"\.dump"
syn match	aasmInclude		"@set"
syn keyword	aasmConditional		ba bz bn bnz bne[g] be bl ble[u] bg bge[u] bcc bcs bpos bvc bvs
syn region	aasmSection		matchgroup=aasmLoop start="\<.section\>" end="\<.ends\>"
syn region	aasmProc		matchgroup=aasmLoop start="\<.proc\>" end="\<.endp\>"
syn match	aasmProc		"\.proc"
syn match	aasmProc		"\.endp"
syn match       aasmRegister            "%g0"
syn match       aasmRegister            "%g1"
syn match       aasmRegister            "%g2"
syn match       aasmRegister            "%g3"
syn match       aasmRegister            "%g4"
syn match       aasmRegister            "%g5"
syn match       aasmRegister            "%g6"
syn match       aasmRegister            "%g7"
syn match       aasmRegister            "%l0"
syn match       aasmRegister            "%l1"
syn match       aasmRegister            "%l2"
syn match       aasmRegister            "%l3"
syn match       aasmRegister            "%l4"
syn match       aasmRegister            "%l5"
syn match       aasmRegister            "%l6"
syn match       aasmRegister            "%l7"
syn match       aasmRegister            "%i0"
syn match       aasmRegister            "%i1"
syn match       aasmRegister            "%i2"
syn match       aasmRegister            "%i3"
syn match       aasmRegister            "%i4"
syn match       aasmRegister            "%i5"
syn match       aasmRegister            "%i6"
syn match       aasmRegister            "%i7"
syn match       aasmRegister            "%o0"
syn match       aasmRegister            "%o1"
syn match       aasmRegister            "%o2"
syn match       aasmRegister            "%o3"
syn match       aasmRegister            "%o4"
syn match       aasmRegister            "%o5"
syn match       aasmRegister            "%o6"
syn match       aasmRegister            "%o7"
syn match	aasmSpecial		display contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"
syn region	aasmString		start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=aasmSpecial,@Spell
syn match	aasmCharacter		"L\='[^\\]'"
syn match	aasmCharacter		"L'[^']*'" contains=aasmSpecial
syn match	aasmSpecialCharacter	display "L\='\\\o\{1,3}'"
syn match	aasmSpecialCharacter	display "'\\x\x\{1,2}'"
syn match	aasmSpecialCharacter	display "L'\\x\x\+'"
syn match	aasmLabel		"[A-Za-z][A-Za-z0-9_]*:"
syn keyword	aasmDelayedOps		call ret nop
syn match	aasmMacroVar		"\$[0-9]"

" Numbers: {{{1
" ========

"integer number, or floating point number without a dot and with "f".
syn match	aasmNumbers	display transparent "\<\d\|\.\d" contains=aasmNumber,aasmFloat,aasmOctal
" Same, but without octal error (for comments)
syn match	aasmNumbersCom	display contained transparent "\<\d\|\.\d" contains=aasmNumber,aasmFloat,aasmOctal
syn match	aasmNumber		display contained "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
"hex number
syn match	aasmNumber		display contained "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"
" Flag the first zero of an octal number as something special
syn match	aasmOctal		display contained "0\o\+\(u\=l\{0,2}\|ll\=u\)\>" contains=aasmOctalZero
syn match	aasmOctalZero	display contained "\<0"
syn match	aasmFloat		display contained "\d\+f"
"floating point number, with dot, optional exponent
syn match	aasmFloat		display contained "\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\="
"floating point number, starting with a dot, optional exponent
syn match	aasmFloat		display contained "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
"floating point number, without dot, with exponent
syn match	aasmFloat		display contained "\d\+e[-+]\=\d\+[fl]\=\>"
"hexadecimal floating point number, optional leading digits, with dot, with exponent
syn match	aasmFloat		display contained "0x\x*\.\x\+p[-+]\=\d\+[fl]\=\>"
"hexadecimal floating point number, with leading digits, optional dot, with exponent
syn match	aasmFloat		display contained "0x\x\+\.\=p[-+]\=\d\+[fl]\=\>"

" Constants: {{{1
" ==========
syn match	aasmConstant		"\.data"
syn match	aasmConstant		"\.rodata"
syn match	aasmConstant		"\.text"
syn match	aasmConstant		"\.bss"

" Comments: {{{1
" =========
syn cluster	aasmCommentGroup	contains=aasmTodo,@Spell
syn keyword	aasmTodo		contained TODO FIXME NOTE WARNING
syn match	aasmComment		";.*$" contains=@aasmCommentGroup

" Default Highlighting: {{{1
" =====================
hi def link	aasmTodo		Todo
hi def link	aasmComment		Comment
hi def link	aasmLoop		aasmStatement

hi def link	aasmProc		Function
hi def link	aasmConstant		Constant
hi def link	aasmKeyword		PreProc
hi def link	aasmMacroVar		PreProc
hi def link	aasmRegister		Special
hi def link	aasmConditional		Conditional
hi def link	aasmInclude		Include
hi def link	aasmString		String
hi def link	aasmCharacter		Character
hi def link	aasmSpecialCharacter	Special
hi def link	aasmSpecial		SpecialChar
hi def link	aasmType		Type
hi def link	aasmNumber		Number
hi def link	aasmFloat		Float
hi def link	aasmOctal		Number
hi def link	aasmLabel		Label
hi def link	aasmDelayedOps		Typedef
