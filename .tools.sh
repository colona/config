# Various tools as alias or functions, should work with most shells.

function 7z {
	if [ -d "$1" ]; then
		7zr a -mx=9 "$(basename $1).7z" "$1" && rm -rf "$1"
	else
		7zr "$@"
	fi
}
function mkcd { mkdir -p "$1" && cd "$1"; }
function noaslr { setarch "$(uname -m)" -R "$@"; }
function nonet { sg no-network "$@"; }
function man {
	# from https://wiki.archlinux.org/index.php/Man_Page#Colored_man_pages
	env LESS_TERMCAP_mb=$'\e[1;31m' \
		LESS_TERMCAP_md=$'\e[1;31m' \
		LESS_TERMCAP_me=$'\e[0m' \
		LESS_TERMCAP_se=$'\e[0m' \
		LESS_TERMCAP_so=$'\e[1;44;33m' \
		LESS_TERMCAP_ue=$'\e[0m' \
		LESS_TERMCAP_us=$'\e[1;32m' \
			man "$@"
}
function img {
	# by http://www.reddit.com/user/xkero
	for image in "$@"; do
		convert -thumbnail $(tput cols) "$image" txt:-\
			| awk -F '[)(,]' '!/^#/{gsub(/ /,"");printf"\033[48;2;"$3";"$4";"$5"m "}'
		echo -e "\e[0;0m"
	done
}
function pdfmerge { output="$1"; shift; gs -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile="$output" -dBATCH "$@"; }
function args_as_stdin { if [ $# -le 1 ]; then $1; else cmd="$1"; shift; echo -nE "$@" | $cmd; fi; }

# byte conversion
function _hex2str { echo -n "'"; while read -r -N 2 byte; do echo -nE '\x'$byte; done; echo "'"; }
function _str2hex { while read -r -N 4 byte; do echo -nE ${byte:2:2}; done; echo ""; }
alias str2hex='args_as_stdin _str2hex'
alias hex2str='args_as_stdin _hex2str'
alias bin2hex='args_as_stdin "xxd -p"'
alias hex2bin='args_as_stdin "xxd -p -r"'
function bin2str { bin2hex "$@" | hex2str; }
function str2bin { str2hex "$@" | hex2bin; }

# specially to assemble and disassemble
function disa { objdump -d -M intel "$1" | less; }
function disahex16 { hex2bin "$1" | ndisasm -b 16 -; }
function disahex32 { hex2bin "$1" | ndisasm -b 32 -; }
function disahex64 { hex2bin "$1" | ndisasm -b 64 -; }
function __disahex_gas {
	file=`mktemp` || return 1
	hex2bin "$1" > $file
	objdump -D -b binary -m $2 --prefix-addresses --show-raw-insn $file | sed -n '6~1p'
	rm -f $file
}
function disahex16_gas {  __disahex_gas "$1" "i8086"; }
function disahex32_gas {  __disahex_gas "$1" "i386"; }
function disahex64_gas {  __disahex_gas "$1" "i386:x86-64"; }
function disahexarm_gas {  __disahex_gas "$1" "arm"; }
function disahexarmthumb_gas {  __disahex_gas "$1" "arm -M force-thumb"; }
function __ashex_nasm {
	file=`mktemp` || return 1
	echo "BITS $1\n" > $file
	cat > $file
	nasm -f bin -o /dev/stdout $file | bin2hex
	rm -f $file
}
alias ashex16='__ashex_nasm 16'
alias ashex32='__ashex_nasm 32'
alias ashex64='__ashex_nasm 64'
function __ashex_gas {
	file=`mktemp` && inter=`mktemp` && output=`mktemp` || return 1
	cat > $file || return 1
	as $1 -o $inter $file || return 1
	objcopy -O binary $inter $output || return 1
	bin2hex < $output
	rm -f $file $inter $output
}
alias ashex32_gas='__ashex_gas --32'
alias ashex64_gas='__ashex_gas --64'
alias ashexarm_gas='__ashex_gas'
alias ashexarmthumb_gas='__ashex_gas -mthumb'
