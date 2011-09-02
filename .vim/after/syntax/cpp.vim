" Vim syntax file
" Language:	C++
" Maintainer:	Tsuna
" Last Change:	2008 Aug 28

" C++ extentions
syn match cppSTL		"\(\<std::\)\@<=\w\+"
syn match cppSTLnamespace	"\<std\ze::"

hi link cppSTL		Function
hi link cppSTLnamespace	StorageClass

" vim: ts=8
