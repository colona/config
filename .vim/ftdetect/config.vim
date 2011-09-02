""
"" config.vim for vim-ftdetect in /home/tsuna/work/transformers
""
"" Made by SIGOURE Benoit
"" Mail   <sigoure.benoit@lrde.epita.fr>
""
"" Started on  Fri Jul 21 00:00:13 2006 SIGOURE Benoit
"" Last update Fri Jul 21 00:01:25 2006 SIGOURE Benoit
""

au BufRead,BufNewFile *
        \       if getline(1) =~ '-\*-Autoconf-\*-' |
        \         set filetype=config |
        \       endif

