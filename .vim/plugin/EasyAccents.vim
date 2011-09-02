" EasyAccents.vim: converts a` a' etc during insert mode
"
"  Author:  Charles E. Campbell, Jr. (PhD)
"  Date:    Feb 10, 2003
"  Version: 4
"
"  Usage:
"
"   These maps all work during insert mode.
"   Type a' a` A' c, etc and accented characters result.
"
"   If you want a vowel (or [bBcC]) to be followed by an accent,
"   use a backslash to escape it:  a\'  for example will become a'
"
"   Sourcing this file acts as a toggle to switch EasyAccents on
"   and off.  By default, the mapping <Leader>ea will toggle
"   EasyAccents, too, by calling <Plug>ToggleEasyAccents .
"
"  Caveat: the maps will not work if "set paste" is on, so that's"
"          another way to bypass EasyAccents as needed.
"
"  Installation:
"
"   EasyAccents is now designed to be toggled on and off.  When on
"   it may interfere with programming languages which often use
"   characters such as single-quotes, backquotes, etc.
"
" "For I am convinced that neither death nor life, neither angels nor demons,
"  neither the present nor the future, nor any powers, nor height nor depth,
"  nor anything else in all creation, will be able to separate us from the
"  love of God that is in Christ Jesus our Lord."  Rom 8:38
" =======================================================================

" prevent re-load
if !exists("g:loaded_EasyAccents")
 let g:loaded_EasyAccents= 0

 if !hasmapto('<Plug>ToggleEasyAccents')
  map  <unique> <Leader>ea <Plug>ToggleEasyAccents
  imap <unique> <Leader>ea <Plug>InsToggleEasyAccents
 endif
 map  <silent> <script> <Plug>ToggleEasyAccents    :set lz<CR>:call <SID>ToggleEasyAccents()<CR>:set nolz<CR>
 imap <silent> <script> <Plug>InsToggleEasyAccents <c-o>:set lz<bar>:call <SID>ToggleEasyAccents()<bar>:set nolz<CR>

 " EasyAccents:
 function! <SID>EasyAccents(type)
  let akeep  = @a
  let vekeep = &ve
  set ve=
  norm! "ayhl
 

  if a:type == ","

   if @a =~ "[cC]"
    exe "norm! xr\<c-k>".@a.a:type
   elseif @a =~ "[bB]"
    exe "norm! xr\<c-k>ss"
   elseif @a == '\'
	exe "norm! xr".a:type
   endif

  else

   if @a =~ "[aAeEiIoOuU]"
    exe "norm! xr\<c-k>".@a.a:type
  
   elseif @a == '\'
    if a:type == '?'
     exe "norm! xr~"
    elseif a:type == '!'
     exe "norm! xr`"
    elseif a:type == '>'
     exe "norm! xr^"
    else
     exe "norm! xr".a:type
    endif
   endif
   endif
 
  let @a = akeep
  let &ve= vekeep

  if &ve != "" && &ve != "block" 
   norm! l
  endif
 endfunction

 fu! <SID>ToggleEasyAccents()
  if g:loaded_EasyAccents == 0 " -----------------------------------------
   " Turn EasyAccents on
   let g:loaded_EasyAccents= 1
   
   " EasyAccents: this function changes the preceding accented character
   inoremap <silent> `  `<c-o>:call <SID>EasyAccents("!")<CR>
   inoremap <silent> '  '<c-o>:call <SID>EasyAccents("'")<CR>
   inoremap <silent> ^  ^<c-o>:call <SID>EasyAccents(">")<CR>
   inoremap <silent> :  :<c-o>:call <SID>EasyAccents(":")<CR>
   inoremap <silent> ~  ~<c-o>:call <SID>EasyAccents("?")<CR>
   inoremap <silent> ,  ,<c-o>:call <SID>EasyAccents(",")<CR>
  
   echo "EasyAccents enabled"
   
  else " -----------------------------------------------------------------
   " Turn EasyAccents off
   let g:loaded_EasyAccents= 0
   iunmap `
   iunmap '
   iunmap ^
   iunmap :
   iunmap ~
   iunmap ,
  
   echo "EasyAccents disabled"
  endif " ----------------------------------------------------------------
 endfunction

 finish
endif

call <SID>ToggleEasyAccents()
