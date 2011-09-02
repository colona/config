" sautofile.vim
" create script sh, ruby, perl and python

if has("autocmd")
  aug coding
    au BufNewFile configure call SSh_New()
    au BufNewFile *.sh call SSh_New()
    au BufNewFile *.rb call SRuby_New()
    au BufNewFile *.pl call SPerl_New()
    au BufNewFile *.py call SPython_New()
    au BufNewFile *.pike call SPike_New()

"    au BufWritePre configure call SUpdate_Headers()
"    au BufWritePre *.sh call SUpdate_Headers()
"    au BufWritePre *.rb call SUpdate_Headers()
"    au BufWritePre *.pl call SUpdate_Headers()
"    au BufWritePre *.py call SUpdate_Headers()
"    au BufWritePre *.pike call SUpdate_Headers()
  aug END

  function SReplaceFields(cs, cm, ce)
    let l:project_name = input("Enter project name: ")
    if l:project_name == ''
      let l:project_name = "Project"
    endif
    execute "% s,@CS@," . a:cs . ",ge"
    execute "% s,@CM@," . a:cm . ",ge"
    execute "% s,@CE@," . a:ce . ",ge"
    execute "% s,@FILE-NAME@," . expand('%:t') . ",ge"
    execute "% s,@PROJECT-NAME@," . l:project_name . ",ge"
    execute "% s,@USER-MAIL@," . g:me_mail . ",ge"
    execute "% s,@USER-NAME@," . g:me_name . ",ge"
    execute "% s/@DATE-STAMP@/" . strftime("%a %b %e %T %Y") . "/ge"
    execute "% s,@PWD@," . $PWD . ",ge"
  endfun

  function SSh_New()
    0r ~/.vim/skel/script.tpl
    call SReplaceFields('#!/bin/sh', '##', '##')
    normal G
  endfun

  function SRuby_New()
    0r ~/.vim/skel/script.tpl
    call SReplaceFields('#!/usr/bin/env ruby', '##', '##')
    normal G
  endfun

  function SPerl_New()
    0r ~/.vim/skel/script.tpl
    call SReplaceFields('#!/usr/bin/env perl', '##', '##')
    normal G
  endfun

  function SPython_New()
    0r ~/.vim/skel/script.tpl
    call SReplaceFields('#!/usr/bin/env python', '##', '##')
    normal G
  endfun

  function SPike_New()
    0r ~/.vim/skel/script.tpl
    call SReplaceFields('#!/usr/bin/env pike', '//', '//')
    normal G
  endfun

  function SUpdate_Headers()
    execute "1,8 s,\\(Last update \\).*,\\1" . strftime("%a %b %e %T %Y") . " " . g:me_name . ","
    map z <C-O>
    normal z
    unmap z
  endfun
endif
