#!/bin/bash

# change working directory to this repo
cd "${0%/*}"
path=$(pwd)

source ./util.sh

printf "Creating symlinks...\n"

link_file ".bashrc" ".bashrc"
link_file ".bash_aliases" ".bash_aliases"
link_file ".ideavimrc" ".ideavimrc"
link_file ".vimrc" ".vimrc"
link_file ".Xmodmap" ".Xmodmap"
link_file ".inputrc" ".inputrc"
link_file ".tmux.conf" ".tmux.conf"
link_file "alacritty/alacritty.yml" ".config/alacritty/alacritty.yml"

printf "%-40s" ".vim/after/syntax/tex/tex.vim"
find ~/.vim/after/syntax/tex/tex.vim -delete >/dev/null 2>&1
mkdir -p ~/.vim/after/syntax/tex
ln -s ${path}/tex.vim ~/.vim/after/syntax/tex/tex.vim
printf "%40s\n" "DONE"

printf "%-40s" ".vim/after/syntax/nerdtree.vim"
find ~/.vim/after/syntax/nerdtree.vim -delete >/dev/null 2>&1
ln -s ${path}/nerdtree.vim ~/.vim/after/syntax/nerdtree.vim
printf "%40s\n" "DONE"

printf "%-40s" "vim templates"
find ~/.vim/templates -delete >/dev/null 2>&1
ln -s ${path}/vim_templates ~/.vim/templates
printf "DONE\n"

printf "%-40s" "sh scripts"
find ~/bin -delete >/dev/null 2>&1
ln -s ${path}/bin ~/bin
printf "DONE\n"
