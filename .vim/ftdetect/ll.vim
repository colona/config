""
"" ll.vim for vim-filetype in /goinfre/work/tp/ex_01
""
"" Made by SIGOURE Benoit
"" Login   <sigour_b@epita.fr>
""
"" Started on  Tue Jan  3 17:54:43 2006 SIGOURE Benoit
"" Last update Tue Jan  3 17:56:10 2006 SIGOURE Benoit
""

"" Override filetype for ll files (ViM normally detects them as LIFELINE
"" files) and for lex filetype
au BufRead,BufNewFile *.ll		set filetype=lex
