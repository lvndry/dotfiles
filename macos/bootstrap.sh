#!/usr/bin/env bash
set -euo pipefail

# Zero-deps bootstrap for a fresh Mac: installs CLT, Homebrew, clones repo over HTTPS, runs setup

echo "Installing Xcode Command Line Tools (if needed)..."
if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install || true
  echo "If a popup appeared, complete the installation, then re-run this script."
fi

if ! command -v /usr/bin/git >/dev/null 2>&1; then
  echo "Waiting for Command Line Tools to provide git..."
fi

echo "Installing Homebrew (if needed)..."
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

REPO_DIR="$HOME/dotfiles"
if [ ! -d "$REPO_DIR" ]; then
  echo "Cloning dotfiles repo over HTTPS..."
  git clone https://github.com/lvndry/dotfiles.git "$REPO_DIR"
fi

cd "$REPO_DIR/macos"
exec bash setup.sh


