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
	eval "`dircolors -b`"
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
addspammed() { echo "$1" >> ~/Maildir/spammed; }
addspammer() { echo "$1" >> ~/Maildir/spammer; }
addspamcontent() { echo "$1" >> ~/Maildir/spam_content; }
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
alias tm='exec tmux a -d'
alias gdb='gdb -q'

# exports
export HISTCONTROL=ignoredups
export EDITOR=vim
export PAGER=less
export NNTPSERVER='news.epita.fr'
export CC=gcc

# input mode
set -o emacs
