#!/bin/bash

# Load utils
. setup/utils.sh

print_title "Xcode"

if [ -d "$(xcode-select -p)" ]; then
    print_warning "xcode-select: already installed"
else
    xcode-select --install
fi
