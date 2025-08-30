#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Starting macOS setup..."

# Create a simple logging function
log() {
  echo "$(date '+%H:%M:%S') 📋 $1"
}

error() {
  echo "$(date '+%H:%M:%S') ❌ $1" >&2
}

success() {
  echo "$(date '+%H:%M:%S') ✅ $1"
}

# Ensure we're in the right directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Verify prerequisites
if ! command -v xcode-select >/dev/null 2>&1; then
  error "Xcode Command Line Tools not found. Run bootstrap.sh first."
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  error "Homebrew not found. Run bootstrap.sh first."
  exit 1
fi

# Update Homebrew first
log "Updating Homebrew..."
brew update

# Install from Brewfile if it exists
if [ -f "$SCRIPT_DIR/Brewfile" ]; then
  log "Installing packages from Brewfile..."
  brew bundle --file="$SCRIPT_DIR/Brewfile" --no-lock
  success "Brewfile packages installed"
else
  error "Brewfile not found in $SCRIPT_DIR"
fi

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  log "Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  success "Oh My Zsh installed"
else
  success "Oh My Zsh already installed"
fi

# Setup FZF key bindings and completions
if command -v fzf >/dev/null 2>&1; then
  log "Setting up FZF..."
  if [ -f "$(brew --prefix)/opt/fzf/install" ]; then
    "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
    success "FZF configured"
  fi
fi

# Create necessary directories
log "Creating config directories..."
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.ssh"
mkdir -p "$HOME/Desktop/Screenshots"
mkdir -p "$HOME/Developer"

# Set proper SSH permissions
if [ -d "$HOME/.ssh" ]; then
  chmod 700 "$HOME/.ssh"
  if [ -f "$HOME/.ssh/config" ]; then
    chmod 600 "$HOME/.ssh/config"
  fi
fi

# Backup existing dotfiles
backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$backup_dir"

for file in .zshrc .zprofile .gitconfig .vimrc; do
  if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
    log "Backing up existing $file to $backup_dir"
    mv "$HOME/$file" "$backup_dir/"
  fi
done

# Link dotfiles
log "Linking dotfiles..."
if [ -f "$SCRIPT_DIR/../shell/.zshrc" ]; then
  ln -sf "$SCRIPT_DIR/../shell/.zshrc" "$HOME/.zshrc"
  success "Linked .zshrc"
fi

if [ -f "$SCRIPT_DIR/../shell/.zprofile" ]; then
  ln -sf "$SCRIPT_DIR/../shell/.zprofile" "$HOME/.zprofile"
  success "Linked .zprofile"
fi

if [ -f "$SCRIPT_DIR/../git/.gitconfig" ]; then
  ln -sf "$SCRIPT_DIR/../git/.gitconfig" "$HOME/.gitconfig"
  success "Linked .gitconfig"
fi

# Setup macOS preferences
if [ -f "$SCRIPT_DIR/macos-dev-setup.sh" ]; then
  log "Applying macOS preferences..."
  bash "$SCRIPT_DIR/macos-dev-setup.sh"
  success "macOS preferences applied"
fi

# Setup development environments
log "Setting up development environments..."

# Python with pyenv and uv
if command -v pyenv >/dev/null 2>&1; then
  log "Setting up Python environment..."
  # Install latest Python if none installed
  if ! pyenv versions | grep -q "[0-9]\+\.[0-9]\+\.[0-9]\+"; then
    latest_python=$(pyenv install --list | grep -E '^\s*[0-9]+\.[0-9]+\.[0-9]+$' | tail -1 | tr -d ' ')
    pyenv install "$latest_python"
    pyenv global "$latest_python"
    success "Installed Python $latest_python"
  fi
  
  # Install uv (fast Python package manager)
  if ! command -v uv >/dev/null 2>&1; then
    log "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    success "uv installed"
  else
    success "uv already installed"
  fi
fi

# Node.js setup with fnm
log "Setting up Node.js environment with fnm..."
if command -v fnm >/dev/null 2>&1; then
  # Install latest LTS Node.js
  fnm install --lts
  fnm use --lts
  fnm default --lts
  
  # Install bun
  npm install -g bun
  
  success "Node.js LTS installed with fnm"
else
  warn "fnm not found. Install it with: brew install fnm"
fi

# Final setup
log "Running final setup tasks..."

# Set shell to zsh if not already
if [ "$SHELL" != "$(which zsh)" ]; then
  log "Setting shell to zsh..."
  chsh -s "$(which zsh)"
fi

# Generate SSH key if none exists
if [ ! -f "$HOME/.ssh/id_ed25519" ] && [ ! -f "$HOME/.ssh/id_rsa" ]; then
  log "Generating SSH key..."
  read -p "Enter your email for SSH key: " email
  if [ -n "$email" ]; then
    ssh-keygen -t ed25519 -C "$email" -f "$HOME/.ssh/id_ed25519" -N ""
    success "SSH key generated at ~/.ssh/id_ed25519.pub"
    echo "Your public SSH key:"
    cat "$HOME/.ssh/id_ed25519.pub"
  fi
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "📋 Next steps:"
echo "  1. Open a new terminal to load shell changes"
echo "  2. Run 'p10k configure' to setup Powerlevel10k theme"
echo "  3. Add your SSH key to GitHub/GitLab:"
echo "     cat ~/.ssh/id_ed25519.pub | pbcopy"
echo "  4. Configure Git with your details:"
echo "     git config --global user.name 'Your Name'"
echo "     git config --global user.email 'your.email@example.com'"
echo ""
echo "💡 Tips:"
echo "  - Set terminal font to 'MesloLGS NF' for best Powerlevel10k experience"
echo "  - Restart Finder and Dock to see all changes: killall Finder Dock"
echo "  - Some macOS settings require logout/restart to take effect"

if [ -d "$backup_dir" ] && [ "$(ls -A "$backup_dir" 2>/dev/null)" ]; then
  echo "  - Your old dotfiles were backed up to: $backup_dir"
fi
