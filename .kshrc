#! /bin/ksh

# custom functions
function 7z {
	if [ -d "$1" ]; then 7zr a -mx=9 "$(basename $1).7z" "$1" && rm -rf "$1";
	else 7zr "$@"; fi
}
function disa { objdump -d -M intel "$1" | less; }
function mkcd { mkdir "$1"; cd "$1"; }
function addspamed { echo "$1" >> ~/Maildir/spammed; }
function addspamer { echo "$1" >> ~/Maildir/spammer; }
function addspamcontent { echo "$1" >> ~/Maildir/spam_content; }
function noaslr { setarch "$(uname -m)" -R "$@"; }
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

# aliases
	# configuration
alias emacs='emacs -nw'
alias rm='rm -Iv --one-file-system'
alias grep='grep --color --binary-files=text'
alias w3m='w3m -T text/html'
alias cal='cal -m'
alias objdump='objdump -M intel'
alias ls='ls --color=auto'
alias gdb='gdb -q'
alias hexer='hexer -c "set bg=16"'

	# new commands
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
alias valfuel='valgrind --leak-check=full --show-reachable=yes --track-fds=yes --read-var-info=yes --track-origins=yes'

# prompt: just "\u@\h:\w$ ", with the $ changing color according to last $?
# All this \1\r and $'\1' shit is to advise ksh to not count the chars for the
# length of the prompt. Yeah, it's ugly...
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

# input
set -o emacs
bind '^L=clear-screen'
