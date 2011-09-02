" vim: set sw=2 ts=2 : "
if !exists("cvs_macros_loaded")
	let cvs_macros_loaded = 1
	if has("gui_running")
		nmenu C&VS.&Add<Tab>;CA :!cvs add %
	  "use this one if you want a window to popup
		nmenu C&VS.&Commit<Tab>;CC :!cvs commit -m "`gprompt -l CVSLog:`" %
		"nmenu C&VS.&Commit<Tab>;CC :echo "enter log string:" <bar> !cvs commit -m "$<" %
		nmenu C&VS.&Diff<Tab>;CD :!cvs diff %
		nmenu C&VS.&History<Tab>;CH :!cvs history %
		nmenu C&VS.&Log<Tab>;CL :!cvs log %
		nmenu C&VS.&Status<Tab>;CS :!cvs status %
		nmenu C&VS.&Update<Tab>;CU :!cvs update %
	endif
	nmap	;CA :!cvs add %
	"use this one if you want a window to popup
	nmap	;CC :!cvs commit -m "`gprompt -l CVSLog:`" %
	"nmap	;CC :echo "enter log string: " <bar> !cvs commit -m "$<" %
	nmap	;CD :!cvs diff %
	nmap	;CH :!cvs history %
	nmap	;CL :!cvs log %
	nmap	;CS :!cvs status %
	nmap	;CU :!cvs update %
endif
