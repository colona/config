" tautofile.vim
" create tiger files

if has("autocmd")
  aug coding
    au BufNewFile *.tig call TTig_New()
    au BufNewFile *.tih call TTih_New()

    au BufWritePre *.tig call TUpdate_Headers()
    au BufWritePre *.tih call TUpdate_Headers()
  aug END

  function TReplaceFields(cs, cm, ce)
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
  
  function TUpdate_Headers()
    execute "1,8 s,\\(Last update \\).*,\\1" . strftime("%a %b %e %T %Y") . " " . g:me_name . ","
    map z <C-O>
    normal z
    unmap z
  endfun
  
  function TTig_New()
    0r ~/.vim/skel/tig.tpl
    0r ~/.vim/skel/tiger.tpl
    normal Gdd
    call TReplaceFields('/*', '**', '*/')
    execute "12"
  endfun

  function TTih_New()
    0r ~/.vim/skel/tih.tpl
    0r ~/.vim/skel/tiger.tpl
    normal Gdd
    call TReplaceFields('/*', '**', '*/')
    execute "12"
  endfun
endif
