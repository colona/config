""
"" cpp.vim for vim-syntax in /u/a1/sigour_b/.vim/ftdetect
""
"" Made by SIGOURE Benoit
"" Login   <sigour_b@epita.fr>
""
"" Started on  Mon Feb 20 14:25:11 2006 SIGOURE Benoit
"" Last update Mon Feb 20 18:35:00 2006 SIGOURE Benoit
""

au BufRead,BufNewFile *.hcc set filetype=cpp 
au BufRead,BufNewFile * 
        \       if getline(1) =~ '.*-\*- C++ -\*-.*' |
        \         set filetype=cpp |
        \       endif
