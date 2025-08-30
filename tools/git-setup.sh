#!/usr/bin/env bash
set -euo pipefail

# Git Setup Tool
# Usage: ./tools/git-setup.sh
# The script will prompt for name and email with defaults from existing Git config

# Get user information for Git configuration
echo "📝 Setting up Git configuration..."

# Get name with default from existing Git config
DEFAULT_NAME=$(git config user.name || echo "Your Name")
read -p "Enter your name for Git commits [$DEFAULT_NAME]: " NAME
NAME="${NAME:-$DEFAULT_NAME}"

# Get email with default from existing Git config
DEFAULT_EMAIL=$(git config user.email || echo "your-email@example.com")
read -p "Enter your email for Git commits [$DEFAULT_EMAIL]: " EMAIL
EMAIL="${EMAIL:-$DEFAULT_EMAIL}"

echo "Setting up Git configuration for: $NAME <$EMAIL>"

# Global Git configuration
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global push.autoSetupRemote true

# Set vim as the default editor for Git commit messages
git config --global core.editor "vim"
git config --global core.autocrlf input
git config --global core.excludesfile ~/.gitignore_global

# Create global gitignore
cat > ~/.gitignore_global << 'EOF'
# macOS
.DS_Store
.AppleDouble
.LSOverride

# Thumbnails
._*

# Files that might appear in the root of a volume
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns
.com.apple.timemachine.donotpresent

# Directories potentially created on remote AFP share
.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk

# Node.js
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
.venv/

# IDEs
.vscode/
.idea/
*.swp
*.swo
*~

# Logs
*.log
logs/

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Coverage directory used by tools like istanbul
coverage/

# nyc test coverage
.nyc_output

# Dependency directories
jspm_packages/

# Optional npm cache directory
.npm

# Optional REPL history
.node_repl_history

# Output of 'npm pack'
*.tgz

# Yarn Integrity file
.yarn-integrity

# dotenv environment variables file
.env
.env.local
.env.development.local
.env.test.local
.env.production.local
EOF


# Git credential helper for macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    git config --global credential.helper osxkeychain
fi

# Setup Git hooks directory
mkdir -p ~/.git-templates/hooks

# Create a sample pre-commit hook
cat > ~/.git-templates/hooks/pre-commit << 'EOF'
#!/bin/sh
# Pre-commit hook to run basic checks

# Check for trailing whitespace
if git diff --cached --check; then
    echo "✓ No trailing whitespace found"
else
    echo "✗ Trailing whitespace found. Please fix and commit again."
    exit 1
fi

# Check for merge conflict markers
if git diff --cached | grep -E "^<<<<<<<|^=======|^>>>>>>>"; then
    echo "✗ Merge conflict markers found. Please resolve conflicts and commit again."
    exit 1
fi

echo "✓ Pre-commit checks passed"
EOF

chmod +x ~/.git-templates/hooks/pre-commit

# Configure Git to use the template directory
git config --global init.templateDir ~/.git-templates

echo "✓ Git configuration complete!"
echo "✓ Global gitignore created at ~/.gitignore_global"
echo "✓ Git aliases configured"
echo "✓ Pre-commit hook template created"
echo ""
