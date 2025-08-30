#!/usr/bin/env bash
set -euo pipefail

# macOS Developer Setup Script
# A curated collection of settings for developers, hackers, and engineers
# Usage: ./macos-dev-setup.sh

echo "🚀 Setting up macOS for world-class development..."

# Ask for sudo password upfront
sudo -v

# Keep sudo alive
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# ============================================================================
# Essential System Settings
# ============================================================================

echo "⚙️  Configuring core system settings..."

# Speed up window animations (but keep them functional)
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable auto-correct and smart substitutions (essential for coding)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Enable full keyboard access for all controls (Tab through everything)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# ============================================================================
# Dock Configuration
# ============================================================================

echo "🎯 Optimizing Dock for productivity..."

# Set Dock size and position
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock magnification -bool false

# Speed up Dock animations
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Keep Dock visible but minimize animations
defaults write com.apple.dock autohide -bool false

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Group windows by application in Mission Control
defaults write com.apple.dock expose-group-by-app -bool true

# ============================================================================
# Finder Enhancements
# ============================================================================

echo "📁 Enhancing Finder for power users..."

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show status bar and path bar
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Show full path in window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Use current folder as default search scope
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable file extension change warning
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Show volumes on desktop (useful for developers)
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Avoid creating .DS_Store files on network and USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Enable Finder quit option
defaults write com.apple.finder QuitMenuItem -bool true

# ============================================================================
# Screenshots and Screen Recording
# ============================================================================

echo "📸 Optimizing screenshot settings..."

# Save screenshots to Desktop/Screenshots
mkdir -p "${HOME}/Desktop/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"

# Save screenshots in PNG format
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# ============================================================================
# Terminal Configuration
# ============================================================================

echo "💻 Configuring Terminal..."

# Enable Secure Keyboard Entry in Terminal
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Only use UTF-8 in Terminal
defaults write com.apple.terminal StringEncodings -array 4

# ============================================================================
# Safari Developer Settings
# ============================================================================

echo "🌐 Setting up Safari for development..."

# Show full URL in address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Enable Develop menu and Web Inspector
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add Web Inspector to context menus
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Disable AutoFill (security best practice)
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Enable "Do Not Track"
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# ============================================================================
# Security and Privacy
# ============================================================================

echo "🔒 Enhancing security settings..."

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Enable firewall stealth mode
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# ============================================================================
# Keyboard and Input
# ============================================================================

echo "⌨️  Optimizing keyboard settings..."

# Set blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Enable key repeat for all applications (helpful in VS Code, etc.)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# ============================================================================
# Essential Developer Shortcuts
# ============================================================================

echo "⚡ Setting up power-user keyboard shortcuts..."

# Enable App Switcher with Command+Tab (ensure it's optimized)
# Make App Switcher faster and more responsive
defaults write com.apple.dock workspaces-auto-swoosh -bool false

# Hot corners for productivity (optional but useful)
# Top-left: Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top-right: Desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom-right: Quick Note (if available) or Notification Center
defaults write com.apple.dock wvous-br-corner -int 12
defaults write com.apple.dock wvous-br-modifier -int 0

# Configure some useful global shortcuts via System Preferences domains
# Note: Some shortcuts need to be set manually in System Preferences > Keyboard > Shortcuts

# Create a shortcuts reference file for manual setup
cat > ~/Desktop/keyboard-shortcuts-reference.txt << 'EOF'
🎯 ESSENTIAL KEYBOARD SHORTCUTS FOR DEVELOPERS
=============================================

SYSTEM SHORTCUTS (Set these in System Preferences > Keyboard > Shortcuts):
• Spotlight Search: ⌘ + Space (default, but verify it's enabled)
• Switch Input Sources: ⌃ + Space (change if needed to avoid conflicts)
• Show Desktop: F11 or ⌘ + F3
• Mission Control: F3 or ⌃ + ↑

APP SHORTCUTS (System Preferences > Keyboard > Shortcuts > App Shortcuts):
• All Applications > "Minimize": ⌘ + M
• All Applications > "Zoom": ⌘ + Shift + M
• Finder > "New Terminal at Folder": ⌘ + T
• Terminal > "New Window": ⌘ + N
• Terminal > "New Tab": ⌘ + T

DEVELOPMENT WORKFLOW:
• Quick file search: ⌘ + Space then type filename
• App switching: ⌘ + Tab (hold ⌘, press Tab to cycle)
• Window switching within app: ⌘ + ` (backtick)
• Force quit: ⌘ + Option + Esc
• Screenshot selection: ⌘ + Shift + 4
• Screenshot window: ⌘ + Shift + 4 + Space
• Lock screen: ⌃ + ⌘ + Q

FINDER SHORTCUTS:
• New folder: ⌘ + Shift + N
• Go to folder: ⌘ + Shift + G
• Show/hide hidden files: ⌘ + Shift + . (period)
• Go to Home: ⌘ + Shift + H
• Go to Desktop: ⌘ + Shift + D
• Go to Applications: ⌘ + Shift + A
• Go to Utilities: ⌘ + Shift + U

TEXT EDITING (Universal):
• Beginning of line: ⌘ + ←
• End of line: ⌘ + →
• Beginning of document: ⌘ + ↑
• End of document: ⌘ + ↓
• Delete word: Option + Delete
• Delete to end of line: ⌘ + Delete

HOT CORNERS (Already configured):
• Top-left: Mission Control
• Top-right: Desktop
• Bottom-right: Quick Note/Notifications

Remember to customize these based on your workflow!
EOF

# ============================================================================
# Activity Monitor
# ============================================================================

echo "📊 Configuring Activity Monitor..."

# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# Show CPU usage in Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# ============================================================================
# Time Machine
# ============================================================================

echo "⏰ Configuring Time Machine..."

# Prevent Time Machine from prompting for new backup volumes
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# ============================================================================
# App Store
# ============================================================================

echo "🏪 Configuring App Store..."

# Enable automatic update checks
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Download updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install system data files and security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# ============================================================================
# Google Chrome (if installed)
# ============================================================================

echo "🌍 Configuring Chrome settings..."

# Disable backswipe navigation (interferes with development)
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false

# Use system print dialog
defaults write com.google.Chrome DisablePrintPreview -bool true

# ============================================================================
# Development-Specific Settings
# ============================================================================

echo "⚡ Applying development-specific optimizations..."

# Show ~/Library folder (contains important dev files)
chflags nohidden ~/Library

# Show /Volumes folder
sudo chflags nohidden /Volumes

# Set default text editor for files without extensions
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{LSHandlerContentType="public.plain-text";LSHandlerRoleAll="com.microsoft.VSCode";}'

# ============================================================================
# Restart Applications
# ============================================================================

echo "🔄 Restarting applications to apply changes..."

# Kill affected applications
for app in "Activity Monitor" "Dock" "Finder" "Safari" "SystemUIServer" "Terminal"; do
    killall "${app}" &> /dev/null || true
done

echo ""
echo "✅ macOS developer setup complete!"
echo ""
echo "🎉 Your Mac is now optimized for world-class development!"
echo ""
echo "Key improvements made:"
echo "  • Enhanced Finder with hidden files, extensions, and paths visible"
echo "  • Faster keyboard repeat rates for efficient coding"
echo "  • Security hardening with firewall and password requirements"
echo "  • Safari configured for web development"
echo "  • Optimized Dock and window animations"
echo "  • Screenshot organization and better formats"
echo "  • Development-friendly text handling"
echo ""
echo "⚠️  Some changes may require a logout/restart to take full effect."
echo "🔧 Consider installing: Homebrew, VS Code, iTerm2, and other dev tools next!"
