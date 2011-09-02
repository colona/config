""
"" stratego-shell.vim for vim-syntax in /home/lrde/lrde-2008/sigoure/.vim/syntax
""
"" Made by SIGOURE Benoit
"" Login   <sigoure@epita.fr>
""
"" Started on  Tue Feb 28 00:14:36 2006 SIGOURE Benoit
"" Last update Wed Apr  5 14:11:41 2006 SIGOURE Benoit
""

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Import the Stratego syntax
if version < 600
  so <sfile>:p:h/stratego.vim
else
  runtime! syntax/stratego.vim
  unlet b:current_syntax
endif

" stratego-shell extensions

syntax keyword	strsImportKw	import contained
syntax match	strsCmd		":\w\+" contained

syntax region	strsCmdRegion	start=":\w\+" end=";;" contains=strsCmd
syntax region	strsImport	start="import" end=";;" contains=strsImportKw


if version >= 508 || !exists("did_strs_syntax_inits")
  if version < 508
    let did_strs_syntax_inits = 1
  endif

  hi link strsImportKw		PreProc
  hi link strsCmd		Special
endif

let b:current_syntax = "stratego-shell"
