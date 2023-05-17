#!/bin/bash

./install_common.sh

# Change working directory to repository
cd "${0%/*}"
path=$(pwd)

source ./util.sh

link_file "Manjaro/conky/conky.conf" ".config/conky/conky.conf"
link_file "Manjaro/.manjaro_aliases" ".manjaro_aliases"
