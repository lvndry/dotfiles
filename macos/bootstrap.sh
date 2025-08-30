#!/usr/bin/env bash
set -euo pipefail

# Zero-deps bootstrap for a fresh Mac: installs CLT, Homebrew, clones repo over HTTPS, runs setup

echo "🚀 Starting fresh Mac bootstrap..."

# Check if we're on macOS
if [[ ! "$OSTYPE" == darwin* ]]; then
  echo "❌ This script is for macOS only"
  exit 1
fi

echo "📦 Installing Xcode Command Line Tools (if needed)..."
if ! xcode-select -p >/dev/null 2>&1; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install || true
  echo "⏳ Waiting for Command Line Tools installation..."
  echo "If a popup appeared, complete the installation, then re-run this script."
  
  # Wait for installation to complete
  while ! xcode-select -p >/dev/null 2>&1; do
    sleep 5
    echo "Still waiting for Command Line Tools..."
  done
fi

# Verify git is available
if ! command -v git >/dev/null 2>&1; then
  echo "❌ Git not found. Please ensure Command Line Tools are installed."
  exit 1
fi

echo "🍺 Installing Homebrew (if needed)..."
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add Homebrew to PATH for both Intel and Apple Silicon Macs
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f "/usr/local/bin/brew" ]]; then
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "✅ Homebrew already installed"
fi

# Verify Homebrew is working
if ! command -v brew >/dev/null 2>&1; then
  echo "❌ Homebrew installation failed or not in PATH"
  exit 1
fi

REPO_DIR="$HOME/dotfiles"
if [ ! -d "$REPO_DIR" ]; then
  echo "📁 Cloning dotfiles repo over HTTPS..."
  git clone https://github.com/lvndry/dotfiles.git "$REPO_DIR"
else
  echo "✅ Dotfiles repo already exists, pulling latest changes..."
  cd "$REPO_DIR"
  git pull origin main || git pull origin master || true
fi

echo "🔧 Running setup script..."
cd "$REPO_DIR/macos"
exec bash setup.sh
