#!/bin/bash

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
