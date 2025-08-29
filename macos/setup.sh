#!/usr/bin/env bash
set -euo pipefail

echo "Starting macOS setup..."

if ! command -v xcode-select >/dev/null 2>&1; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install || true
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

BREWFILE_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -f "$BREWFILE_DIR/Brewfile" ]; then
  echo "Installing Brewfile packages..."
  brew bundle --file="$BREWFILE_DIR/Brewfile"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Installing zsh plugins and theme via Homebrew..."
brew list --formula powerlevel10k >/dev/null 2>&1 || brew install powerlevel10k
brew list --formula zsh-autosuggestions >/dev/null 2>&1 || brew install zsh-autosuggestions
brew list --formula zsh-syntax-highlighting >/dev/null 2>&1 || brew install zsh-syntax-highlighting
brew list --formula fzf >/dev/null 2>&1 || brew install fzf
brew list --formula zoxide >/dev/null 2>&1 || brew install zoxide
brew list --formula direnv >/dev/null 2>&1 || brew install direnv
brew list --formula uv >/dev/null 2>&1 || brew install uv
brew list --formula node >/dev/null 2>&1 || brew install node
brew list --formula bun >/dev/null 2>&1 || brew install bun

# Ensure new CLI utilities
for formula in bat tldr fd ripgrep eza git-delta; do
  brew list --formula "$formula" >/dev/null 2>&1 || brew install "$formula"
done

# Ensure GUI apps
for app in warp postico raycast arc spotify cursor font-meslo-lg-nerd-font; do
  brew list --cask "$app" >/dev/null 2>&1 || brew install --cask "$app" || true
done

if [ -f "$(brew --prefix)/opt/fzf/install" ]; then
  "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc
fi

echo "Linking dotfiles..."
mkdir -p "$HOME/.config"
ln -sf "$BREWFILE_DIR/../shell/.zshrc" "$HOME/.zshrc"
ln -sf "$BREWFILE_DIR/../shell/.zprofile" "$HOME/.zprofile"

echo "Setup complete. Open a new terminal to load changes."
echo "Tip: In your terminal settings, set the font to 'MesloLGS NF' for powerlevel10k."
