""
"" config.vim for Project in /home/tsuna
""
"" Made by SIGOURE Benoit
"" Mail   <sigoure.benoit@lrde.epita.fr>
""
"" Started on  Wed Mar 22 00:23:52 2006 SIGOURE Benoit
"" Last update Thu Jul 20 23:28:52 2006 SIGOURE Benoit
""

" Language:	configure.in script: M4 with sh
" Based on Christian Hammesr's work (<ch@lathspell.westend.com>)

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" define the config syntax
syn match   configDelimiter	"[()\[\];,]"
syn match   configTrigraph  "@\(<:\|:>\)@"
syn match   configOperator	"[=|&\*\+\<\>]"
syn match   configComment	"\(dnl.*\)\|\(#.*\)" contains=@Spell
syn match   configFunction	"\<[A-Z_][A-Z0-9_]*\>"
syn match   configAutoConf	"\<AC_[A-Z_][A-Z0-9_]*\>"
syn match   configAutoMake	"\<AM_[A-Z_][A-Z0-9_]*\>"
syn match   configAutoShell	"\<AS_[A-Z_][A-Z0-9_]*\>"
syn match   configAutoScan	"\<AN_[A-Z_][A-Z0-9_]*\>"
syn match   configAutoHeader	"\<AH_[A-Z_][A-Z0-9_]*\>"
syn match   configM4		"\<m4_\w\+\>"
syn match   configNumber	"[-+]\=\<\d\+\(\.\d*\)\=\>"
syn keyword configKeyword	if then elif else fi test for in do done
syn region  configString	start=+"+ skip=+\\"+ end=+"+ contains=@Spell
syn region  configString	start=+'+ skip=+\\'+ end=+'+ contains=@Spell
syn region  configString	start=+`+ skip=+\\`+ end=+`+ contains=@Spell

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_config_syntax_inits")
  if version < 508
    let did_config_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink configDelimiter	Delimiter
  HiLink configOperator		Operator
  HiLink configComment		Comment
  HiLink configFunction		Macro
  HiLink configNumber		Number
  HiLink configKeyword		Keyword
  HiLink configString		String
  HiLink configAutoConf		Keyword
  HiLink configAutoMake		Type
  HiLink configAutoShell	Type
  HiLink configAutoScan		Type
  HiLink configAutoHeader	Type
  HiLink configM4			Type
  HiLink configTrigraph		Character

  delcommand HiLink
endif

let b:current_syntax = "config"

" vim: ts=4
