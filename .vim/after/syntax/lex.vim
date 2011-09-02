""
"" lex.vim for vim-syntax in /u/a1/sigour_b/.vim/after/syntax
""
"" Made by SIGOURE Benoit
"" Login   <sigour_b@epita.fr>
""
"" Started on  Tue Jan  3 17:57:28 2006 SIGOURE Benoit
"" Last update Thu Jan  5 18:48:30 2006 SIGOURE Benoit
""

syn match	lexOption	"%option"

hi link		lexOption	Special

" override colors defined by default: they're too ugly
hi def link lexPat		String
hi def link lexPatString	String
