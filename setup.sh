#!/bin/bash

# dotfiles path
DOTFILES_PATH="$HOME/dotfiles"

# Load utils
. $DOTFILES_PATH/setup/utils.sh

check_os() {
    os_name="$(uname)"
    if [ "$os_name" != "Darwin" ]; then
        print_error "Sorry, this script is intended only for macOS"
        exit 1
    fi
}

download_dotfiles() {
    print_title "Download dotfiles"
    if [ -d $DOTFILES_PATH ]; then
        print_warning "dotfiles: already exists"
    else
        print_message "Downloading dotfiles..."
        if type git > /dev/null 2>&1; then
            git clone https://github.com/n2kia4/dotfiles.git
        else
            curl -sL https://github.com/n2kia4/dotfiles/archive/master.tar.gz | tar xz
            mv dotfiles-master dotfiles
        fi
        print_success "successfully downloaded"
    fi
}

download_tpm() {
    if [[ -d ~/.tmux/plugins/tpm ]]; then
        print_werning "tpm: already exists"
    else
        print_message "Downloading tpm..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        print_success "successfully downloaded"
    fi
}

change_login_shell() {
    print_title "Zsh"
    if [ $SHELL == $(which zsh) ]; then
        print_warning "Login shell: already zsh"
    else
        print_message "Changing login shell..."
        grep "$(which zsh)" /etc/shells &>/dev/null || sudo sh -c "echo $(which zsh) >> /etc/shells"
        chsh -s $(which zsh)
        print_success "successfully changed to zsh"
    fi
}

reboot_system() {
    print_title "Reboot System"
    printf "Do you want to reboot the system? (y/n) "
    read
    if [[ $REPLY =~ ^[Yy]$ || $REPLY == '' ]]; then
        sudo shutdown -r now &> /dev/null
    fi
}

reload_shell() {
    printf "\n\n"
    exec $(which zsh)
}

main() {
    check_os
    download_dotfiles

    . $DOTFILES_PATH/setup/symbolic_links.sh
    . $DOTFILES_PATH/setup/install/main.sh
    . $DOTFILES_PATH/setup/preferences/main.sh

    download_tpm

    ~/.tmux/plugins/tpm/scripts/install_plugins.sh

    change_login_shell
    reboot_system
    reload_shell
}

main
