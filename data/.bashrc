#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias getmeout='. ~/.getmezsh.sh'

echo "WARN: Currently using bash. Not zsh."
. "$HOME/.cargo/env"

complete -C /usr/bin/terraform terraform
