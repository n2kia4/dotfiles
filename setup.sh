#!/bin/bash

DOTFILES_PATH="$HOME/dotfiles"

# Download dotfiles
if [ -d $DOTFILES_PATH ]; then
    echo "[SKIP] Download dotfiles"
else
    echo "Downloading dotfiles..."
    if type git > /dev/null 2>&1; then
        git clone https://github.com/n2kia4/dotfiles.git
    else
        curl -sL https://github.com/n2kia4/dotfiles/archive/master.tar.gz | tar xz
    fi
    echo "[OK] Download dotfiles"
fi

cd $DOTFILES_PATH

# Symbolic link
for file in .??*
do
    filepath="${PWD}/${file}"

    [[ "$file" == ".git" ]] && continue
    [[ "$file" == ".gitignore" ]] && continue
    [[ "$file" == ".DS_Store" ]] && continue

    ln -sfnv $filepath $HOME/$file
done
echo "[OK] Symbolic link"

# Install Homebrew
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
        autoconf coreutils git go openssl \
        python python3 rbenv readline ruby-build \
        sbt tmux vim zsh
    echo "[OK] Install Packages"
fi

# Install Vim plugin
vim +PlugInstall +qall
echo "[OK] Install Vim plugin"

# Change the login shell
if [ $SHELL == $(which zsh) ]; then
    echo "[SKIP] Change the login shell"
else
    grep "$(which zsh)" /etc/shells &>/dev/null || sudo sh -c "echo $(which zsh) >> /etc/shells"
    chsh -s $(which zsh)
    echo "[OK] Change the login shell"
fi

exec $(which zsh)
