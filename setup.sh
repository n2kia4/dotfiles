#!/bin/bash

for file in .??*
do
  filepath="${PWD}/${file}"

  [[ "$file" == ".git" ]] && continue
  [[ "$file" == ".gitignore" ]] && continue
  [[ "$file" == ".DS_Store" ]] && continue

  ln -s $filepath $HOME/$file
done
