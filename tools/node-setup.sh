#!/usr/bin/env bash
set -euo pipefail

# Node.js Development Environment Setup
# Usage: ./tools/node-setup.sh [node_version]
# Example: ./tools/node-setup.sh 20
# If no version specified, uses LTS

NODE_VERSION="${1:-}"

echo "Setting up Node.js development environment..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is required. Please install it first:"
    echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

# Install Node.js version manager (fnm - fast and simple)
echo "📦 Installing fnm (Fast Node Manager)..."
brew install fnm

# Add fnm to shell configuration
if [[ "$SHELL" == *"zsh"* ]]; then
    if ! grep -q "fnm" ~/.zshrc; then
        echo 'eval "$(fnm env --use-on-cd)"' >> ~/.zshrc
    fi
elif [[ "$SHELL" == *"bash"* ]]; then
    if ! grep -q "fnm" ~/.bashrc; then
        echo 'eval "$(fnm env --use-on-cd)"' >> ~/.bashrc
    fi
fi

# Source fnm for current session
eval "$(fnm env --use-on-cd)"

# Install Node.js
if [[ -z "$NODE_VERSION" ]]; then
    echo "📦 Installing latest LTS Node.js..."
    fnm install --lts
    fnm use lts/latest
    fnm default lts/latest
else
    echo "📦 Installing Node.js $NODE_VERSION..."
    fnm install $NODE_VERSION
    fnm use $NODE_VERSION
    fnm default $NODE_VERSION
fi

# Show installed version
INSTALLED_VERSION=$(fnm current)
echo "✅ Using Node.js $INSTALLED_VERSION"

# Install global packages
echo "📦 Installing global Node.js packages..."

# Package manager
npm install -g bun

# Create common npm configuration
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'

# Add npm global bin to PATH
if [[ "$SHELL" == *"zsh"* ]]; then
    if ! grep -q "npm-global" ~/.zshrc; then
        echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
    fi
elif [[ "$SHELL" == *"bash"* ]]; then
    if ! grep -q "npm-global" ~/.bashrc; then
        echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
    fi
fi

# Get user information for npm configuration
echo "📝 Setting up npm configuration..."
read -p "Enter your name for npm packages: " NPM_NAME
read -p "Enter your email for npm packages: " NPM_EMAIL

# Create .npmrc with useful defaults
cat > ~/.npmrc << EOF
# Save exact version
save-exact=true

# Set default registry
registry=https://registry.npmjs.org/

# Set default init values
init.author.name=$NPM_NAME
init.author.email=$NPM_EMAIL
init.license=MIT

# Performance settings
maxsockets=50
fetch-retries=3
fetch-retry-mintimeout=10000
fetch-retry-maxtimeout=60000

# Security
audit=true
fund=false
EOF


echo "✓ Node.js development environment setup complete!"
echo ""
echo "Installed tools:"
echo "  - fnm (Node.js version manager)"
echo "  - Node.js $INSTALLED_VERSION"
echo "  - bun"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Use 'fnm list' to see installed Node.js versions"
echo "  3. Use 'fnm install <version>' to install additional versions"
