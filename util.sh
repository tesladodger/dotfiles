#!/bin/bash

# Creates a symlink to a file in this repo
# $1 - relative path to the file
# $2 - path where the link should be placed, relative to ~
link_file () {
    origin=$1
    dest=$2
    printf "%-40s" "$dest"
    find ~/$dest -delete >/dev/null 2>&1
    ln -s ${path}/${origin} ~/$dest
    printf "DONE \n"
}
