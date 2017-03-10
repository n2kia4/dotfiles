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
which -s brew
if [[ $? != 0 ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "[OK] Install Homebrew"
else
    echo "[SKIP] Install Homebrew"
fi

# Install Vim plugin
vim +PlugInstall +qall
echo "[OK] Install Vim plugin"
