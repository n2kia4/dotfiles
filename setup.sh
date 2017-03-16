#!/bin/bash

DOTFILES_PATH="$HOME/dotfiles"

check_os() {
    os_name="$(uname)"
    if [ "$os_name" != "Darwin" ]; then
        echo "Sorry, this script is intended only for macOS"
        exit 1
    fi
}

download_dotfiles() {
    if [ -d $DOTFILES_PATH ]; then
        echo "[SKIP] Download dotfiles"
    else
        echo "Downloading dotfiles..."
        if type git > /dev/null 2>&1; then
            git clone https://github.com/n2kia4/dotfiles.git
        else
            curl -sL https://github.com/n2kia4/dotfiles/archive/master.tar.gz | tar xz
            mv dotfiles-master dotfiles
        fi
        echo "[OK] Download dotfiles"
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
    echo "[OK] Create symbolic links"
}

install_homebrew() {
    if type brew > /dev/null 2>&1; then
        echo "[SKIP] Install Homebrew"
    else
        echo "Installing Homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        echo "[OK] Install Homebrew"
    fi

    echo "Run brew update..."
    brew update

    echo "Run brew doctor..."
    brew doctor

    echo "Installing packages..."
    brew install \
        autoconf coreutils git go hub openssl \
        python python3 rbenv readline ruby-build \
        sbt sqlite tmux tree vim zsh
    echo "[OK] Install Packages"
}

install_vim_plugins() {
    echo "Installing Vim plugins..."
    vim +PlugInstall +qall > /dev/null 2>&1
    echo "[OK] Install Vim plugins"
}

update_vim_plugins() {
    echo "Updating Vim plugins..."
    vim +PlugUpdate +qall > /dev/null 2>&1
    echo "[OK] Update Vim plugins"
}

change_login_shell() {
    if grep "$(which zsh)" /etc/shells &>/dev/null; then
        echo "[SKIP] Change the login shell"
    else
        sudo sh -c "echo $(which zsh) >> /etc/shells"
        chsh -s $(which zsh)
        echo "[OK] Change the login shell"
    fi
}

reload_shell() {
    $(which zsh) ~/.zshrc
}

main() {
    check_os
    download_dotfiles
    symbolic_links
    install_homebrew
    install_vim_plugins
    update_vim_plugins
    change_login_shell
    reload_shell
}

main
