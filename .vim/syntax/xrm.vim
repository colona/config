""
"" xrm.vim for vim-syntax in /home/tsuna/.vim/syntax
""
"" Made by SIGOURE Benoit
"" Mail   <sigoure.benoit@lrde.epita.fr>
""
"" Started on  Tue Jul 11 11:50:49 2006 SIGOURE Benoit
"" Last update Tue Jul 11 12:22:39 2006 SIGOURE Benoit
""

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn keyword	xrmTodo		contained TODO FIXME XXX NOTE[S]
syn cluster	xrmCommentGroup	contains=xrmTodo

syn keyword	xrmTypes	const bool double int rate prob exp
syn keyword	xrmBool		true false
syn keyword	xrmBuiltins	func ceil floor max min pow rand static_rand
syn keyword	xrmModelTypes	probabilistic dtmc nondeterministic mdp stochastic ctmc
syn keyword	xrmBlocks	init endinit module endmodule rewards endrewards system endsystem properties
syn keyword	xrmKeywords	formula global label Pmin Pmax Rmin Rmax C F G I P R S U X
syn keyword	xrmConditional	if then else end
syn keyword	xrmRepeat	for from to step in do
syn match	xrmNumbers	"\<\d\+\(.\d\+\)\=\>"

syntax region	xrmCommentLine	start="//" skip="\\$" end="$" contains=@xrmCommentGroup,@Spell

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_xrm_syn_inits")
  if version < 508
    let did_xrm_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink xrmCommentLine		Comment
  HiLink xrmTypes		Type
  HiLink xrmBool		Boolean
  HiLink xrmBuiltins		Operator
  HiLink xrmModelTypes		Special
  HiLink xrmBlocks 		Underlined
  HiLink xrmKeywords		Structure
  HiLink xrmNumbers		Number
  HiLink xrmConditional		Conditional
  HiLink xrmRepeat		Repeat

  delcommand HiLink
endif

let b:current_syntax = "xrm"

" vim: ts=8
