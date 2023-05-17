#!/bin/bash

./install_common.sh

# Change working directory to repository
cd "${0%/*}"
path=$(pwd)

source ./util.sh

link_file "Arch/i3/config" ".config/i3/config"
link_file "Arch/i3status/config" ".config/i3status/config"
link_file "Arch/.arch_aliases" ".arch_aliases"
