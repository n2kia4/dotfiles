#!/bin/bash

# Load utils
. setup/utils.sh

install_homebrew() {
    print_title "Homebrew"
    if type brew > /dev/null 2>&1; then
        print_warning "Homebrew: already installed"
    else
        print_message "Installing Homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        print_success "successfully installed"
    fi

    print_message "brew update..."
    if brew update > /dev/null 2>&1; then
        print_success "successfully updated"
    else
        print_error "unsuccessfully updated"
    fi

    print_message "brew doctor..."
    if brew doctor > /dev/null 2>&1; then
        print_success "ready to brew"
    else
        print_error "not ready to brew"
    fi
}

install_packages() {
    print_title "Homebrew Packages"
    print_message "Installing packages..."
    packages=(
        autoconf buku coreutils git gitbucket go gtk+3 hub \
        imagemagick lua mongodb mysql node openssl peco postgresql \
        python python3 pwgen rbenv readline ruby-build \
        sbt sqlite tig tmux tree vim wget zsh
    )
    for package in "${packages[@]}"; do
        if brew list "$package" > /dev/null 2>&1; then
            print_warning "$package: already installed"
        elif brew install $package > /dev/null 2>&1; then
            print_success "$package: successfully installed"
        else
            print_error "$package: unsuccessfully installed"
        fi
    done
}

main() {
    install_homebrew
    install_packages
}

main
