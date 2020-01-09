#!/bin/sh

repo=https://github.com/lvndry/dotfiles

download_dotfiles() {
    git clone $repo ~/dotfiles
}

download_dotfiles
mkdir -p ~/.config
cp -v -r ~/dotfiles/* ~/.config