#! /bin/ksh

# custom functions
7z()
{
  if [ -d "$1" ]; then 7zr a -mx=9 "`basename $1`.7z" "$1";
  else 7zr $@; fi
}
disa() { objdump -d -M intel $1 | most; }
hexd() { hexdump -C $1 | most; }
mkcd() { mkdir $1; cd $1; }

# aliases
alias emacs='emacs -nw'
alias rm='rm -Iv --one-file-system'
alias grep='grep -i --color'
alias w3m='w3m -T text/html'
alias cal='cal -m'
alias qwerty='setxbdmap us intl'
alias sshot='xwd -root | convert xwd:- ~/screen.png'
alias mkpass='</dev/urandom tr -dc "[:alnum:]" | head -c12; echo'
alias mkpasse='</dev/urandom tr -dc "[:graph:]" | head -c16; echo'
alias x="startx & exit"
alias view='vim -R'
alias objdump='objdump -M intel'
alias ls='ls --color=auto'
alias wakeliza='wol 00:11:85:73:96:10'
alias clock='xclock -d -strftime "%T" -update 1 &'
alias tm='exec tmux a -d'

# prompt: juste \u@\h:\w$, with the $ changing color according to last $?
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
PS1=$PS1'`if [[ $? -eq 0 ]]; then echo -ne "\033[0;32m"; else echo -ne "\033[0;31m"; fi`'
PS1=$PS1'`echo -ne "$\033[0m"` '
export PS1

# environment
export HISTFILE=${HOME}/.ksh_history
export HISTSIZE=4096
export EDITOR=vim
export PAGER=most
export NNTPSERVER='news.epita.fr'
export CC=gcc

# input mode
set -o emacs
