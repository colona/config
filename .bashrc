# Warning: my primary shell is mksh, this file is probably outdated, take a
# look at .kshrc for up-to-date settings.

# tools common to all the shells
source ~/.tools.sh

# Alias definitions.
alias emacs='emacs -nw'
alias rm='rm -Iv --one-file-system'
alias grep='grep -i --color'
alias w3m='w3m -T text/html'
alias cal='cal -m'
alias objdump='objdump -M intel'
alias ls='ls --color=auto'
alias gdb='gdb -q'

alias sshot='xwd -root | convert xwd:- ~/screen.png'
alias mkpass='</dev/urandom tr -dc "[:alnum:]" | head -c12; echo'
alias mkpasse='</dev/urandom tr -dc "[:graph:]" | head -c16; echo'
alias pws='~/.password-store.sh'
alias x="startx & exit"
alias view='vim -R'
alias clock='xclock -d -strftime "%T" -update 1 &'
alias tm='exec tmux a -d'

# exports
export HISTCONTROL=ignoredups
export EDITOR=vim
export PAGER=less
export NNTPSERVER='news.epita.fr'
export CC=gcc
# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
	eval "`dircolors -b`"
fi

# prompt
PS1='\u@\h:\w\$ '
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# input mode
set -o emacs
