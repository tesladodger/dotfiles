#!/usr/bin/env bash

# Deprecated! using archrice/.bashrc

[[ $- != *i* ]] && return

GREEN="\[$(tput setaf 2)\]"
RESET="\[$(tput sgr0)\]"
PS1="\n${GREEN} \u@\h  \w  \$ ${RESET}-> "

# ls COLORS
LS_COLORS=$LS_COLORS:'ex=0;92:''di=0;94' ;
export LS_COLORS

# ex - archive extractor
ex () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

export EDITOR=nvim

export GREP_OPTIONS='--color=auto'

shopt -s histappend

export HISTCONTROL=ignoredups
export HISTSIZE=1000
export HISTFILESIZE=10000

# start ssh agent
eval `ssh-agent -s`

# manpage colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.arch_aliases ]] && . ~/.arch_aliases

PATH="$HOME/.local/bin:$PATH"
