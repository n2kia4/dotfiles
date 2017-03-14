#!/bin/bash

DOTFILES_PATH="$HOME/dotfiles"

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
    if [ $(uname) = 'Darwin' ]; then
        which -s brew
        if [[ $? != 0 ]] ; then
            echo "Installing Homebrew..."
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            echo "[OK] Install Homebrew"
        else
            echo "[SKIP] Install Homebrew"
        fi

        # Run brew update && brew doctor
        echo "Run brew update..."
        brew update

        echo "Run brew doctor..."
        brew doctor

        # Install packages
        echo "Installing packages..."
        brew install \
            autoconf coreutils git go hub openssl \
            python python3 rbenv readline ruby-build \
            sbt sqlite tmux tree vim zsh
        echo "[OK] Install Packages"
    fi
}

install_vim_plugins() {
    vim +PlugInstall +qall
    echo "[OK] Install Vim plugins"
}

update_vim_plugins() {
    vim +PlugUpdate +qall
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

main() {
    download_dotfiles

    cd $DOTFILES_PATH

    symbolic_links
    install_homebrew
    install_vim_plugins
    update_vim_plugins
    change_login_shell

    echo "Done. Please run: exec $(which zsh)"
}

main
