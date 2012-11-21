#! /bin/ksh

# custom functions
7z()
{
	if [ -d "$1" ]; then 7zr a -mx=9 "`basename $1`.7z" "$1" && rm -rf "$1";
	else 7zr "$@"; fi
}
disa() { objdump -d -M intel "$1" | most; }
hexd() { hexdump -C "$1" | most; }
mkcd() { mkdir "$1"; cd "$1"; }
addspamed() { echo "$1" >> ~/Maildir/spammed; }
addspamer() { echo "$1" >> ~/Maildir/spammer; }
addspamcontent() { echo "$1" >> ~/Maildir/spam_content; }
noaslr() { setarch `uname -m` -R "$@"; }
man()
{ # from https://wiki.archlinux.org/index.php/Man_Page#Colored_man_pages
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}

# aliases
alias emacs='emacs -nw'
alias rm='rm -Iv --one-file-system'
alias grep='grep --color --binary-files=text'
alias w3m='w3m -T text/html'
alias cal='cal -m'
alias objdump='objdump -M intel'
alias ls='ls --color=auto'
alias gdb='gdb -q'

alias x="startx & exit"
alias sshot='import -window root ~/screen.png'
alias sshotold='xwd -root | convert xwd:- ~/screen.png'
alias mkpass='</dev/urandom tr -dc "[:alnum:]" | head -c12; echo'
alias mkpasse='</dev/urandom tr -dc "[:graph:]" | head -c16; echo'
alias view='vim -R'
alias clock='xclock -d -strftime "%T" -update 1 &'
alias tm='exec tmux a -d'

# prompt: just \u@\h:\w$, with the $ changing color according to last $?
export HOSTNAME=`hostname`
prettypwd()
{
	TRIMPWD=${PWD#${HOME}}
	if [ ${#PWD} -gt ${#TRIMPWD} ]; then
		echo -n "~$TRIMPWD"
	else
		echo -n "$PWD"
	fi
}
PS1='${USER}@${HOSTNAME}:`prettypwd`'
case "$TERM" in # set the title of terminal emulator
	*xterm* | *rxvt* ) PS1="`echo -ne '\e]0;'`"$PS1"`echo -ne '\a'`"$PS1;;
esac
PS1=$PS1'`if [[ $? -eq 0 ]]; then echo -ne "\e[0;32m"; else echo -ne "\e[0;31m"; fi`'
PS1=$PS1"`echo -ne '$\e[0m'` "
export PS1

# environment
eval "`lesspipe`" # populate $LESSOPEN and $LESSCLOSE
if [ "$TERM" != "dumb" ]; then
	eval "`dircolors -b`" # enable advanced colors for ls
fi
export HISTFILE=${HOME}/.ksh_history
export HISTSIZE=4096
export EDITOR=vim
export PAGER=less
export NNTPSERVER='news.epita.fr'
export CC=gcc

# input mode
set -o emacs
