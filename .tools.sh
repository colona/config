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
alias view='vim -R'
alias rot13='tr abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
alias sshot='import -window root ~/screen.png'
alias sshotold='xwd -root | convert xwd:- ~/screen.png'
alias mkpass='</dev/urandom tr -dc "[:alnum:]" | head -c12; echo'
alias mkpasse='</dev/urandom tr -dc "[:graph:]" | head -c16; echo'

# file renamming
function prepend { # prepend PREFIX FILE...
	prefix="$1"
	shift
	while [ $# -gt 0 ]; do
		mv "$1" "$prefix$1"
		shift
	done
}
function append { # append POSTFIX FILE...
	postfix="$1"
	shift
	while [ $# -gt 0 ]; do
		mv "$1" "$1$postfix"
		shift
	done
}
function prestrip { # prestrip COUNT FILE...
	count="$1"
	shift
	while [ $# -gt 0 ]; do
		mv "$1" "${1:$count:$((${#1} - $count))}"
		shift
	done
}
function poststrip { # poststrip COUNT FILE...
	count="$1"
	shift
	while [ $# -gt 0 ]; do
		mv "$1" "${1:0:$((${#1} - $count))}"
		shift
	done
}

# byte conversion : bin2hex bin2str hex2str hex2bin str2bin str2hex
# all work with `FUNCTION VALUE` or `echo VALUE | FUNCTION`
function args_as_stdin {
	if [ $# -le 1 ]; then
		$1
	else
		cmd="$1"
		shift
		echo -nE "$@" | $cmd
	fi
}
function _str2hex {
	while read -r -N 4 byte; do
		if [ "${byte:0:1}" = "'" ] || [ "${byte:0:1}" = '"' ]; then
			read -r -N 1 tmpbyte
			byte="${byte:1:3}$tmpbyte"
		fi
		echo -nE ${byte:2:2}
	done
	echo
}
function _hex2str {
	echo -n "'"
	while read -r -N 2 byte; do
		echo -nE '\x'$byte
	done
	echo "'"
}
function _bin2tab {
	file="`mktemp`" &&
	cat > "$file" &&
	xxd -i "$file" &&
	rm -f "$file"
}
alias str2hex='args_as_stdin _str2hex'
alias hex2str='args_as_stdin _hex2str'
alias bin2tab='args_as_stdin _bin2tab'
alias hex2bin='args_as_stdin "xxd -p -r"'
function bin2hex { args_as_stdin "xxd -p" "$@" | tr -d '\n'; echo; }
function bin2str { bin2hex "$@" | hex2str; }
function str2bin { str2hex "$@" | hex2bin; }
function hex2tab { hex2bin "$@" | bin2tab; }
function str2tab { str2bin "$@" | bin2tab; }

# specially to assemble and disassemble
function disa { objdump -d -M intel "$1" | less; }
function disahex16 { hex2bin "$@" | ndisasm -b 16 -; }
function disahex32 { hex2bin "$@" | ndisasm -b 32 -; }
function disahex64 { hex2bin "$@" | ndisasm -b 64 -; }
function __disahex_gas {
	file=`mktemp` &&
	arch="$1" &&
	shift &&
	hex2bin "$@" > $file &&
	objdump -D -b binary -m $arch --prefix-addresses --show-raw-insn $file | sed -n '6~1p' &&
	rm -f $file
}
function disahex16_gas {  __disahex_gas "i8086" "$@"; }
function disahex32_gas {  __disahex_gas "i386" "$@"; }
function disahex64_gas {  __disahex_gas "i386:x86-64" "$@"; }
function disahexarm_gas {  __disahex_gas "arm" "$@"; }
function disahexarmthumb_gas {  __disahex_gas "arm -M force-thumb" "$@"; }
function __ashex_nasm {
	file=`mktemp` &&
	echo "BITS $1\n" > $file &&
	cat >> $file &&
	nasm -f bin -o /dev/stdout $file | bin2hex &&
	rm -f $file
}
alias ashex16='__ashex_nasm 16'
alias ashex32='__ashex_nasm 32'
alias ashex64='__ashex_nasm 64'
function __ashex_gas {
	file=`mktemp` && inter=`mktemp` && output=`mktemp` &&
	cat > $file &&
	as $1 -o $inter $file &&
	objcopy -O binary $inter $output &&
	bin2hex < $output &&
	rm -f $file $inter $output
}
alias ashex32_gas='__ashex_gas --32'
alias ashex64_gas='__ashex_gas --64'
alias ashexarm_gas='__ashex_gas'
alias ashexarmthumb_gas='__ashex_gas -mthumb'
