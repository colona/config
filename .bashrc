# WARNING: my primary shell is mksh, this file is probably outdated, take a
# look at .mkshrc for up-to-date settings.

# tools common to all the shells
source ~/.tools.sh

# exports
export HISTCONTROL=ignoredups
export EDITOR=vim
export PAGER=less
export CC=gcc

# prompt
PS1='\u@\h:\w\$ '

# input mode
set -o emacs
