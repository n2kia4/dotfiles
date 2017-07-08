#!/bin/bash

# Load utils
. setup/utils.sh

install_plugins() {
    print_message "Installing Vim plugins..."
    if vim +PlugInstall +qall > /dev/null 2>&1; then
        print_success "successfully installed"
    else
        print_error "unsuccessfully installed"
    fi
}

update_plugins() {
    print_message "Updating Vim plugins..."
    if vim +PlugUpdate +qall > /dev/null 2>&1; then
        print_success "successfully updated"
    else
        print_error "unsuccessfully updated"
    fi
}

main() {
    print_title "---Vim---"

    install_plugins
    update_plugins
}

main
