# custom functions
function 7z {
	if [ -d "$1" ]; then
		7zr a -mx=9 "$(basename $1).7z" "$1" && rm -rf "$1"
	else
		7zr "$@"
	fi
}
function mkcd { mkdir -p "$1" && cd "$1"; }
function addspamed { echo "$1" >> ~/Maildir/spammed; }
function addspamer { echo "$1" >> ~/Maildir/spammer; }
function addspamcontent { echo "$1" >> ~/Maildir/spam_content; }
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

# byte conversion
function arg_as_stdin { if [ $# -le 1 ]; then $1; else cmd="$1"; shift; echo -nE "$@" | $cmd; fi; }
function _hex2str { echo -n "'"; while read -r -N 2 byte; do echo -nE '\x'$byte; done; echo "'"; }
function _str2hex { while read -r -N 4 byte; do echo -nE ${byte:2:2}; done; echo ""; }
alias str2hex='arg_as_stdin _str2hex'
alias hex2str='arg_as_stdin _hex2str'
alias bin2hex='arg_as_stdin "xxd -p"'
alias hex2bin='arg_as_stdin "xxd -p -r"'
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


# aliases
# for configuration
alias emacs='emacs -nw'
alias rm='rm -Iv --one-file-system'
alias grep='grep --color --binary-files=text'
alias w3m='w3m -T text/html'
alias cal='cal -m'
alias objdump='objdump -M intel'
alias ls='ls --color=auto'
alias gdb='gdb -q'
alias hexer='hexer -c "set bg=16"'

# for new commands
alias x='startx & exit'
alias sshot='import -window root ~/screen.png'
alias sshotold='xwd -root | convert xwd:- ~/screen.png'
alias mkpass='</dev/urandom tr -dc "[:alnum:]" | head -c12; echo'
alias mkpasse='</dev/urandom tr -dc "[:graph:]" | head -c16; echo'
alias pws='~/.password-store.sh'
alias view='vim -R'
alias hexd='hexer -R'
alias clock='xclock -d -strftime "%T" -update 1 &'
alias tm='exec tmux a -d'
alias radio='mplayer --prefer-ipv4 --cache=1024 http://radio.ycc.fr:8000/colona'
alias radio64='mplayer --prefer-ipv4 --cache=1024 http://radio.ycc.fr:8000/colona64'
alias valfuel='valgrind --leak-check=full --show-reachable=yes --track-fds=yes --read-var-info=yes --track-origins=yes --malloc-fill=0x42 --free-fill=0x43'
alias rot13='tr abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'


# Prompt: just "\u@\h:\w$ ", with the $ changing color according to last $?
# All this \1\r and $'\1' shit is to advise ksh to not count the chars for the
# length of the prompt. Yeah, it's ugly...
# \1\r must be at the beginning of the string and declares \1 as a delimiter
# for non printable characters.
# Having a \a in the prompt allows the shell to signal when a task is finished
# through the bell, wich alert the user visually in many properly configured
# window managers and terminal multiplexers.
export HOSTNAME="$(hostname)"
function prettypwd {
	TRIMPWD=${PWD#${HOME}}
	if [ ${#PWD} -gt ${#TRIMPWD} ]; then
		echo -n "~$TRIMPWD"
	else
		echo -n "$PWD"
	fi
}
PS1='${USER}@${HOSTNAME}:$(prettypwd)'
case "$TERM" in # set the title of terminal emulator
	*xterm* | *rxvt* ) PS1=$'\1\e]0;'"$PS1"$'\a\1'"$PS1";;
esac
PS1=$'\1\r'"$PS1"
PS1+=$'\1\a\1'
PS1+=$'\1''$(if [[ $? -eq 0 ]]; then echo -ne "\e[0;32m"; else echo -ne "\e[0;31m"; fi)'$'\1'
PS1+=$'$\1\e[0m\1 '
export PS1


# environment
eval "$(lesspipe)" # populate $LESSOPEN and $LESSCLOSE
if [ "$TERM" != "dumb" ]; then
	eval "$(dircolors -b)" # enable advanced colors for ls
fi
export HISTFILE="${HOME}/.ksh_history"
export HISTSIZE=4096
export EDITOR=vim
export PAGER=less
export NNTPSERVER='news.epita.fr'
export CC=gcc
export GTK_IM_MODULE=xim


# input
set -o emacs
bind '^L=clear-screen'
