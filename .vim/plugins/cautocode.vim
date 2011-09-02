" cautocode.vim

if has("autocmd")
  aug coding
    au BufEnter *.[ch],*.C,*.cc,*.cpp,*.hh,*.hxx,*.cxx call CFile_Map()
    au BufLeave *.[ch],*.C,*.cc,*.cpp,*.hh,*.hxx,*.cxx call CFile_UnMap()
    au BufEnter *.hh noremap ;; :call AutoIncludeHH()<CR>
    au BufEnter *.cc noremap ;; :call AutoIncludeCC()<CR>
  aug END

  function CFile_Map()
    imap { {<NL> <BS><NL>}<Up><End>
"    imap [ []<Left>
  endfun

function CFile_UnMap()
    iunmap {
"    iunmap [
  endfun

"  function MyInclude()
"    execute 's/\([A-Z]\)\(\w\+\)\([A-Z]\)\(\w\+\)\([*& ] \w\+\);/#include "\l\1\2-\l\3\4.hh"/'
"    execute 's/\([A-Z]\)\(\w\+\)\([*& ] \w\+\);/#include "\l\1\2-\l\3\4.hh"/'
"    normal dd
"    normal u
"    execute 'noh'
"    execute '5'
"    normal P
"    normal ==
"  endfun

  function AutoIncludeHH()
    let class = expand("<cword>")
    let old_line_num = line(".")
    "let class = getline (".")
    "let class = substitute(class, '\([A-Z]\)\(\w\+\)\([A-Z]\)\(\w\+\)\([ &*] \w\+\);', 'class \1\2\3\4;', "g")
    let x = substitute(class, '\([A-Z]\)\(\w\+\)\([A-Z]\)\(\w\+\)', 'class \1\2\3\4;', "g")
    "let class = substitute(class, '\([A-Z]\)\(\w\+\)\([ &*] \w\+\);', 'class \1\2;', "g")
    if (class == x)
      let x = substitute(class, '\([A-Z]\)\(\w\+\)', 'class \1\2;', "g")
    endif
    if (exists('g:AutoIncludeLine'))
      let line = g:AutoIncludeLine
    else
      line = 5
    endif
    execute '' . line
    normal O
    execute 's/$/\=x/'
    normal ==
    execute '' . old_line_num + 1
  endfun

  function AutoIncludeCC()
    let class = expand("<cword>")
    let old_line_num = line(".")
    "let lol = getline (".")
    let x = substitute(class, '\([A-Z]\)\(\w\+\)\([A-Z]\)\(\w\+\)', '#include "\l\1\2-\l\3\4.hh"', "g")
    if (class == x)
      let x = substitute(x, '\([A-Z]\)\(\w\+\)', '#include "\l\1\2.hh"', "g")
    endif
    if (exists('g:AutoIncludeLine'))
      let line = g:AutoIncludeLine
    else
      line = 5
    endif
    execute '' . line
    normal O
    execute 's/$/\=x/'
    normal ==
    execute '' . old_line_num + 1
  endfun
endif
