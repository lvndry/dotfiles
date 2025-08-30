#!/usr/bin/env bash
set -euo pipefail

# Raycast Setup Tool
# Usage: ./tools/raycast-setup.sh
# This script installs useful Raycast extensions and configures settings

echo "Setting up Raycast with useful extensions..."

# Check if Raycast is installed
if ! command -v raycast &> /dev/null; then
    echo "❌ Raycast is not installed or not in PATH."
    echo "   Please install Raycast first: https://raycast.com/"
    exit 1
fi

echo "✓ Raycast found"

# Install useful extensions
echo "📦 Installing Raycast extensions..."

# Development tools
raycast extensions install homebrew
raycast extensions install github
raycast extensions install git

# Productivity tools
raycast extensions install calendar
raycast extensions install reminders
raycast extensions install notes
raycast extensions install clipboard-history
raycast extensions install system-preference

# System utilities
raycast extensions install network-speed
raycast extensions install battery
raycast extensions install wifi-password
raycast extensions install bluetooth
raycast extensions install volume

# Web tools
raycast extensions install google-search
raycast extensions install wikipedia
raycast extensions install translate
raycast extensions install weather

# Create Raycast configuration directory
RAYCAST_CONFIG_DIR=~/Library/Application\ Support/com.raycast.macos/
mkdir -p "$RAYCAST_CONFIG_DIR"

# Replace Spotlight with Raycast
echo "🔧 Configuring Raycast to replace Spotlight..."
defaults write com.raycast.macos RaycastGlobalHotkey -string "49,1048576"
defaults write com.raycast.macos RaycastGlobalHotkeyEnabled -bool true

# Disable Spotlight keyboard shortcut
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '<dict><key>enabled</key><false/></dict>'

echo "✓ Raycast setup complete!"
echo ""
echo "Installed extensions:"
echo "  - Homebrew (package management)"
echo "  - GitHub (repository management)"
echo "  - Git (version control)"
echo "  - Calendar & Reminders"
echo "  - System utilities"
echo "  - Web tools"
echo ""
echo "Next steps:"
echo "  1. Restart your Mac or log out/in for Spotlight changes to take effect"
echo "  2. Open Raycast (⌘+Space) - now replaces Spotlight!"
echo "  3. Configure your preferences"
echo "  4. Customize your extensions"
