# Various tools as alias or functions, should work with most shells.

7z() {
	if [ -d "$1" ]; then
		7zr a -mx=9 "$(basename "$1").7z" "$1" && rm -rf "$1"
	else
		7zr "$@"
	fi
}
mkcd() { mkdir -p -- "$1" && cd -- "$1"; }
noaslr() { setarch "$(uname -m)" -R -- "$@"; }
nonet() { sg no-network "$@"; }
man() {
	env LESS_TERMCAP_md="$(tput bold; tput setaf 1)" \
		LESS_TERMCAP_us="$(tput bold; tput setaf 2)" \
		LESS_TERMCAP_ue="$(tput sgr0)" \
		LESS_TERMCAP_so="$(tput bold; tput setaf 3; tput setab 4)" \
		LESS_TERMCAP_se="$(tput sgr0)" \
			man "$@"
}
colorize() {
	case "$1" in
		-f) color="mt=1;30";;
		-r) color="mt=1;31";;
		-g) color="mt=1;32";;
		-y) color="mt=1;33";;
		-b) color="mt=1;34";;
		-p) color="mt=1;35";;
		-c) color="mt=1;36";;
		*) cat; return;;
	esac
	pattern="$2"
	shift 2
	GREP_COLORS="$color" grep -E --color=always "$pattern|" | colorize "$@"
}
cpg() {
	cmd="$1"
	shift
	$cmd --color=always "$@" | less -R
}
img() {
	# by http://www.reddit.com/user/xkero
	for image in "$@"; do
		convert -thumbnail "$(tput cols)" "$image" txt:-\
			| awk -F '[)(,]' '!/^#/{gsub(/ /,"");printf"\033[48;2;"$3";"$4";"$5"m "}'
		echo -e "\e[0;0m"
	done
}
wdump() {
	url="$1"
	echo "$url"
	read -r filename?'Filename: '
	filename="${filename// /-}"
	filename="${filename//[!0-9A-Za-z_.-]}.txt"
	echo "$url" >> "$filename"
	w3m -dump "$url" >> "$filename"
	vim -- "$filename"
	sed -ri '/^(Advertisement|Continue reading the main story|Share This Page|Share This Article|Photo)$/d' -- "$filename"
}
ntpget() { # from http://seriot.ch/ntp.php
	for serv in "$@"; do date -d @$((16#$(printf "\xb%-47.s"|nc -uw1 "$serv" 123|xxd -s40 -l4 -p)-2208988800)); done;
}
remind() {
	time="$1"
	shift
	[ "${time:0:1}" = '+' ] && time="now $time"
	echo $"cat <<EOF\n$@\nEOF" | at "$time"
}
nohomerun() {
	dir="$(mktemp -d)" || return 1
	cp $HOME/.Xauthority $dir/
	sudo unshare -m sh -c "mount --bind $dir/ $HOME &&
		exec su $USER -c 'exec $1'"
	echo rm -rf "$dir"
}
overlayrun() {
	dir="$(mktemp -d)" || return 1
	mkdir "$dir/u" "$dir/w"
	cp $HOME/.Xauthority $dir/u/
	sudo unshare -m mksh -c "mount -t overlay overlay -olowerdir=$1,upperdir=$dir/u,workdir=$dir/w $1 &&
		exec su $USER -c 'exec $2'"
	echo rm -rf "$dir"
}
hotp() {
	hkey="$(echo "$1" | tr 'a-z ' 'A-Z' | base32 -d | xxd -p)"
	printf '%016x' "${2:-0}" | xxd -p -r |
		openssl dgst -sha1 -mac HMAC -macopt "hexkey:$hkey" |
		if read __ dgst && [ ${#dgst} -eq 40 ]; then
			off="$((16#${dgst:39} * 2))"
			hotp="0000000$((16#${dgst:$off:8} & 0x7fffffff))"
			echo "${hotp:${#hotp} - ${3:-6}}"
		fi
}
totp() {
	echo -n "for $((${2:-30} - $(date +%s) % ${2:-30})) seconds: "
	hotp "$1" "$(($(date +%s) / ${2:-30} + ${4:-0}))" "${3:-6}"
}
weather() { curl "http://wttr.in/$1"; }
pdfmerge() { output="$1"; shift; gs -dNOPAUSE -sDEVICE=pdfwrite -dAutoRotatePages=/None -sOutputFile="$output" -dBATCH "$@"; }
pdfsplit() { gs -sDEVICE=pdfwrite -dSAFER -dAutoRotatePages=/None -o %03d.pdf "$1"; }
timestamp() { _t() { echo "[$(date +'%x %T.%N')] $1"; }; _t Start; while read -r line; do _t "$line"; done; _t Done; }
lvim() { a="$@"; f="${a%%:*}"; l="$(echo "$@" | cut -s -d : -f 2)"; vim $f ${l:++}$l; }
nfoview() { iconv -f CP437 -t UTF-8 -- "$1" | less; }
alias view='vim -R'
alias rot13='tr abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
alias sshot='import -window root ~/screen.png'
alias sshotold='xwd -root | convert xwd:- ~/screen.png'
alias mkpass='</dev/urandom tr -dc "[:alnum:]" | head -c12; echo'
alias mkpasse='</dev/urandom tr -dc "[:graph:]" | head -c16; echo'
alias wmirror='wget -E --execute robots=off -H -nd -nH -p -k --'
alias urldecode='python -c "import sys, urllib.parse; print(urllib.parse.unquote_plus(sys.argv[1]))"'
alias urlencode='python -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))"'
alias overlayhome='overlayrun $HOME'
alias chromium='overlayhome chromium'

# file renamming
prepend() { # prepend PREFIX FILE...
	prefix="$1"
	shift
	while [ $# -gt 0 ]; do
		mv -- "$1" "$prefix$1"
		shift
	done
}
append() { # append POSTFIX FILE...
	postfix="$1"
	shift
	while [ $# -gt 0 ]; do
		mv -- "$1" "$1$postfix"
		shift
	done
}
prestrip() { # prestrip COUNT FILE...
	count="$1"
	shift
	while [ $# -gt 0 ]; do
		mv -- "$1" "${1:$count:$((${#1} - count))}"
		shift
	done
}
poststrip() { # poststrip COUNT FILE...
	count="$1"
	shift
	while [ $# -gt 0 ]; do
		mv -- "$1" "${1:0:$((${#1} - count))}"
		shift
	done
}

# computations from stdin
alias linesum="linecomp '+'"
linecomp() {
	read -r res
	while read -r line; do
		res="$((res $1 line))"
	done
	echo $res
}
lineavg() {
	read -r res
	count=1
	while read -r line; do
		res=$((res + line))
		count=$((count + 1))
	done
	echo $((res / count))
}

# byte conversion : bin2hex bin2str hex2str hex2bin str2bin str2hex
# all work with `FUNCTION VALUE` or `echo VALUE | FUNCTION`
args_as_stdin() {
	if [ $# -le 1 ]; then
		$1
	else
		cmd="$1"
		shift
		echo -nE "$@" | $cmd
	fi
}
_str2hex() {
	while read -r -N 4 byte; do
		if [ "${byte:0:1}" = "'" ] || [ "${byte:0:1}" = '"' ]; then
			read -r -N 1 tmpbyte
			byte="${byte:1:3}$tmpbyte"
		fi
		echo -nE "${byte:2:2}"
	done
	echo
}
_hex2str() {
	echo -n "'"
	while read -r -N 2 byte; do
		echo -nE '\x'"$byte"
	done
	echo "'"
}
_bin2tab() {
	file="$(mktemp)" &&
	cat > "$file" &&
	xxd -i "$file" &&
	rm -f "$file"
}
alias str2hex='args_as_stdin _str2hex'
alias hex2str='args_as_stdin _hex2str'
alias bin2tab='args_as_stdin _bin2tab'
alias hex2bin='args_as_stdin "xxd -p -r"'
bin2hex() { args_as_stdin "xxd -p" "$@" | tr -d '\n'; echo; }
bin2str() { bin2hex "$@" | hex2str; }
str2bin() { str2hex "$@" | hex2bin; }
hex2tab() { hex2bin "$@" | bin2tab; }
str2tab() { str2bin "$@" | bin2tab; }

# specially to assemble and disassemble
disa() { objdump -d -M intel -w --prefix-addresses --show-raw-insn "$1" | less; }
disahex16() { hex2bin "$@" | ndisasm -b 16 -; }
disahex32() { hex2bin "$@" | ndisasm -b 32 -; }
disahex64() { hex2bin "$@" | ndisasm -b 64 -; }
__disahex_gas() {
	file="$(mktemp)" &&
	arch="$1" &&
	shift &&
	hex2bin "$@" > "$file" &&
	objdump -D -b binary -m "$arch" --prefix-addresses --show-raw-insn "$file" | sed -n '6~1p' &&
	rm -f "$file"
}
disahex16_gas() {  __disahex_gas "i8086" "$@"; }
disahex32_gas() {  __disahex_gas "i386" "$@"; }
disahex64_gas() {  __disahex_gas "i386:x86-64" "$@"; }
disahexarm_gas() {  __disahex_gas "arm" "$@"; }
disahexarmthumb_gas() {  __disahex_gas "arm -M force-thumb" "$@"; }
__ashex_nasm() {
	file="$(mktemp)" &&
	echo $"BITS $1\n" > "$file" &&
	cat >> "$file" &&
	nasm -f bin -o /dev/stdout "$file" | bin2hex &&
	rm -f "$file"
}
alias ashex16='__ashex_nasm 16'
alias ashex32='__ashex_nasm 32'
alias ashex64='__ashex_nasm 64'
__ashex_gas() {
	file="$(mktemp)" && inter="$(mktemp)" && output="$(mktemp)" &&
	cat > "$file" &&
	as "$1" -o "$inter" "$file" &&
	objcopy -O binary "$inter" "$output" &&
	bin2hex < "$output" &&
	rm -f "$file" "$inter" "$output"
}
ashexarmthumb_gas() {
	file="$(mktemp)" && inter="$(mktemp)" && output="$(mktemp)" &&
	echo -e '.thumb\n.syntax unified' > "$file" &&
	cat >> "$file" &&
	as -mthumb -o "$inter" "$file" &&
	objcopy -O binary "$inter" "$output" &&
	bin2hex < "$output" &&
	rm -f "$file" "$inter" "$output"
}
alias ashex32_gas='__ashex_gas --32'
alias ashex64_gas='__ashex_gas --64'
alias ashexarm_gas='__ashex_gas'

# torrent files decoder
benc_getpos() { cat /proc/self/fdinfo/0 | if read __ p; then echo $p >&2; fi }
benc_getint() {
	i="$2"
	while read -r -n 1 c; do
		case "$c" in
			'-') i='-';;
			[0123456789]) i="$i$c";;
			"${1:-e}") echo -n "$i"; return 0;;
			*) exit 1;;
		esac
	done
}
benc_getstr() {
	len="$(benc_getint : $1)"
	test "$len" -eq 0 && return 0
	read -r -n $len s || exit 1
	echo -n "$s" | sed 's/\\/\\\\/g; s/"/\\"/g'
}
benc_getlist() { benc_dispatch && while v="$(benc_dispatch)"; do echo -n ", $v"; done }
benc_getdict() {
	mult=0
	while k="$(benc_dispatch)"; do
		test $mult -eq 1 && echo -n ', '
		case "$k" in
			'"pieces"') echo -n "$k: "; head -c "$(benc_getint :)" | wc -l;;
			'"info"') benc_getpos; echo "$k: $(benc_dispatch)"; benc_getpos;;
			*) echo "$k: $(benc_dispatch)";;
		esac
		mult=1
	done
}
benc_dispatch() {
	read -r -n 1 c
	case "$c" in
		i) benc_getint;;
		[0123456789]) echo -n '"'"$(benc_getstr "$c")"'"';;
		l) echo -n "[$(benc_getlist)]";;
		d) echo -n "{$(benc_getdict)}";;
		e) return 1;;
	esac
}
torrenthash() {
	offs="$(LC_ALL=C benc_dispatch < "$1" 2>&1 >/dev/null)"
	echo $offs | if read b e; then
		dd if="$1" status=none skip=$b bs=1 count=$(($e - $b)) |
			sha1sum | if read h __; then echo $h; fi
	fi
}
torrent2js() { LC_ALL=C benc_dispatch < "$1" 2> /dev/null; }
torrent2jq() { torrent2js "$1" | jq .; }
