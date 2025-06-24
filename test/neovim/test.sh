#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
# check "distro" lsb_release -c
# check "color" [ $(cat /tmp/color.txt | grep red) ]
check "bob --version"
check "echo $PATH | grep nvim-bin"
check "nvim -v"

# Report result
reportResults
