""
"" meta.vim for vim-syntax in /home/tsuna/.vim/syntax
""
"" Made by SIGOURE Benoit
"" Mail   <sigoure.benoit@lrde.epita.fr>
""
"" Started on  Wed Apr  5 14:11:47 2006 SIGOURE Benoit
"" Last update Wed Apr  5 14:13:41 2006 SIGOURE Benoit
""

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Import the SDF syntax
if version < 600
  so <sfile>:p:h/sdf.vim
else
  runtime! syntax/sdf.vim
  unlet b:current_syntax
endif

" stratego-shell extensions

syntax keyword	metaMeta	Meta
syntax keyword	metaSyntax	Syntax

if version >= 508 || !exists("did_meta_syntax_inits")
  if version < 508
    let did_meta_syntax_inits = 1
  endif

  hi link metaMeta		Special
  hi link metaSyntax		Type
endif

let b:current_syntax = "meta"
