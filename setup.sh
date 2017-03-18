#!/bin/bash

DOTFILES_PATH="$HOME/dotfiles"

print_error() {
    printf "\033[31m    [ERROR] $1\033[m\n"
}

print_success() {
    printf "\033[32m    [OK] $1\033[m\n"
}

print_warning() {
    printf "\033[33m    [SKIP] $1\033[m\n"
}

print_message() {
    printf "    $1\n"
}

check_os() {
    os_name="$(uname)"
    if [ "$os_name" != "Darwin" ]; then
        print_error "Sorry, this script is intended only for macOS"
        exit 1
    fi
}

download_dotfiles() {
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
    cd $DOTFILES_PATH
}

symbolic_links() {
    for file in .??*
    do
        filepath="${PWD}/${file}"

        [[ "$file" == ".git" ]] && continue
        [[ "$file" == ".gitignore" ]] && continue
        [[ "$file" == ".DS_Store" ]] && continue

        ln -sfnv $filepath $HOME/$file
    done
    print_success "successfully created"
}

install_homebrew() {
    if type brew > /dev/null 2>&1; then
        print_warning "Homebrew: already installed"
    else
        print_message "Installing Homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        print_success "successfully installed"
    fi

    print_message "Run brew update..."
    brew update

    print_message "Run brew doctor..."
    brew doctor
}

install_packages() {
    print_message "Installing packages..."
    packages=(
        autoconf coreutils git go hub openssl \
        python python3 rbenv readline ruby-build \
        sbt sqlite tmux tree vim zsh
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

install_vim_plugins() {
    print_message "Installing Vim plugins..."
    vim +PlugInstall +qall > /dev/null 2>&1
    print_success "successfully installed"
}

update_vim_plugins() {
    print_message "Updating Vim plugins..."
    vim +PlugUpdate +qall > /dev/null 2>&1
    print_success "successfully updated"
}

change_login_shell() {
    if [ $SHELL == $(which zsh) ]; then
        print_warning "Login shell: already zsh"
    else
        print_message "Changing login shell..."
        grep "$(which zsh)" /etc/shells &>/dev/null || sudo sh -c "echo $(which zsh) >> /etc/shells"
        chsh -s $(which zsh)
        print_success "successfully changed to zsh"
    fi
}

reload_shell() {
    exec $(which zsh)
}

main() {
    check_os
    download_dotfiles
    symbolic_links
    install_homebrew
    install_packages
    install_vim_plugins
    update_vim_plugins
    change_login_shell
    reload_shell
}

main
