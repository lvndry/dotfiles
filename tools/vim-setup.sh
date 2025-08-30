#!/usr/bin/env bash
set -euo pipefail

# Vim Setup Tool
# Usage: ./tools/vim-setup.sh
# This script installs Vundle and sets up vim configuration

echo "Setting up Vim with Vundle..."

# Create vim directories
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/undo

# Install Vundle if not already installed
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    echo "📦 Installing Vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo "✓ Vundle installed"
else
    echo "✓ Vundle already installed"
fi

# Link vimrc
echo "🔗 Linking vimrc..."
if [ -f ~/.vimrc ]; then
    echo "Backing up existing ~/.vimrc to ~/.vimrc.backup"
    mv ~/.vimrc ~/.vimrc.backup
fi

# Copy vimrc from dotfiles
cp vim/.vimrc ~/.vimrc
echo "✓ vimrc linked"

# Install plugins
echo "📦 Installing Vim plugins..."
vim +PluginInstall +qall

echo "✓ Vim setup complete!"
echo ""
echo "Vim plugins installed:"
echo "  - Vundle (plugin manager)"
echo "  - vim-fugitive (Git integration)"
echo "  - vim-airline (status bar)"
echo "  - tagbar (code navigation)"
echo "  - vim-code-dark (theme)"
echo ""
echo "Useful Vim commands:"
echo "  :PluginList       - list installed plugins"
echo "  :PluginInstall    - install plugins"
echo "  :PluginUpdate     - update plugins"
echo "  :PluginClean      - remove unused plugins"
