# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

PS1='\u@\h:\w\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
	#eval "`dircolors -b`"
	eval "`dircolors -b $HOME/.LS_COLORS`"
fi

# custom function
7z()
{
  if [ -d "$1" ]; then 7zr a -mx=9 "`basename $1`.7z" "$1";
  else 7zr $@; fi
}
disa() { objdump -d -M intel $1 | most; }
hexd() { hexdump -C $1 | most; }
mkcd() { mkdir $1; cd $1; }

# Alias definitions.
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

# exports
export HISTCONTROL=ignoredups
export EDITOR=vim
export PAGER=most
export NNTPSERVER='news.epita.fr'
export CC=gcc
#export CFLAGS="-O2 -ansi -pedantic -W -Wall -Werror -Wextra"
#set -o vi
