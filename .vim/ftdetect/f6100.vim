""
"" f6100.vim for corewar in /u/a1/sigour_b/.vim/ftdetect
""
"" Made by SIGOURE Benoit
"" Login   <sigour_b@epita.fr>
""
"" Started on  Tue Nov 29 22:36:01 2005 SIGOURE Benoit
"" Last update Wed Nov 30 00:16:22 2005 SIGOURE Benoit
""

au BufRead,BufNewFile *.f6100		set filetype=f6100
au BufRead,BufNewFile *.s
        \       if getline(1) =~ '^#.*corewar.*' |
        \         set filetype=f6100 |
        \       endif
