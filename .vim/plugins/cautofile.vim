" cautofile.vim
" create *.c *.h *.cc *.hh *.hxx Makefile

if has("autocmd")
  aug coding
    au BufNewFile [Mm]akefile call CMakefile_New()
    au BufNewFile *.hh call HHFile_New()
    au BufNewFile *.cc call CCFile_New()
  aug END

  function CReplaceFields(cs, cm, ce)
    execute "% s,@CS@," . a:cs . ",ge"
    execute "% s,@CM@," . a:cm . ",ge"
    execute "% s,@CE@," . a:ce . ",ge"
    execute "% s,@FILE-NAME@," . expand('%:t') . ",ge"
  endfun

  function CFile_New()
    0r ~/.vim/skel/c.tpl
    call CReplaceFields('/*', '**', '*/')
    normal G
  endfun

  function HFile_New()
    0r ~/.vim/skel/c.tpl
    normal Gdh
    r ~/.vim/skel/h.tpl
    call CReplaceFields('/*', '**', '*/')
    execute "11,14s/-/_/ge"
    execute "11,14s/[.]/_/ge"
    execute "11"
    normal 2wg~$
    execute "12"
    normal 2wg~$
    execute "14"
    normal 4wg~$
    execute "13"
  endfun

  function CCFile_New()
    0r ~/.vim/skel/cc.tpl
    call CReplaceFields('//', '//', '//')
    execute "3s/cc/hh/ge"
    execute "6"
  endfun

  function HHFile_New()
    0r ~/.vim/skel/hh.tpl
    call CReplaceFields('//', '//', '//')
    execute "3,4s/-/_/ge"
    execute "3,4s/[.]/_/ge"
    execute "3"
    normal 2wg~$
    execute "4"
    normal 2wg~$
    execute "11"
    normal 4wg~$
    execute "6s/[.]//ge"
    execute "6s/hh//ge"
    execute "6s/-//ge"
    normal wg~l
    normal f_lg~l
    execute "11s/-/_/ge"
    execute "11s/[.]/_/ge"
    normal zr
    execute "8"
  endfun

  function CMakefile_New()
    0r ~/.vim/skel/c.tpl
    call CReplaceFields('##', '##', '##')
    normal Gdh
    r ~/.vim/skel/makefile.tpl
    execute "11"
  endfun


endif
