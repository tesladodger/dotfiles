#!/bin/bash

alias free='free -m'
alias np='nano -w PKGBUILD'
alias more=less

alias shutn='shutdown now'
alias reboot='shutdown -r now'

alias ls='ls --color=auto'
alias ll='ls -lah'
alias df='df -h'
alias h='cd ~'
alias b='cd ..'
alias bb='cd ../..'
alias bbb='cd ../../..'
alias q='exit'
alias rm='rm -iv'
alias mv='mv -v'
alias cp='cp -v'
alias df='df -h'
alias dirs='dirs -v'

# Git
alias gits='git status'
alias gitdf='git diff'
alias gita='git add'

# Toggle compositor
alias compoff='xfconf-query -c xfwm4 -p /general/use_compositing -s false'
alias compon='xfconf-query -c xfwm4 -p /general/use_compositing -s true'
