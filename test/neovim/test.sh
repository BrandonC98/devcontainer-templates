#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
# check "distro" lsb_release -c
# check "color" [ $(cat /tmp/color.txt | grep red) ]
check "bob is installed" bob --version
check "bob  binary is in the PATH variable" [ $(echo $PATH | grep nvim-bin) ]
check "neovim is installed" nvim -v

# Report result
reportResults
