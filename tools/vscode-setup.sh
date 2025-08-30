#!/usr/bin/env bash
set -euo pipefail

# Cursor/VS Code Setup Tool
# Usage: ./tools/vscode-setup.sh
# This script installs Cursor/VS Code extensions and configures settings

echo "Setting up Cursor/VS Code for development..."

# Check if Cursor or VS Code is installed
if ! command -v cursor &> /dev/null && ! command -v code &> /dev/null; then
    echo "❌ Neither Cursor nor VS Code is installed or not in PATH."
    echo "   Please install Cursor first: https://cursor.sh/"
    echo "   Or install VS Code: https://code.visualstudio.com/"
    exit 1
fi

# Use Cursor if available, otherwise fall back to VS Code
if command -v cursor &> /dev/null; then
    EDITOR_CMD="cursor"
    echo "✓ Using Cursor as editor"
else
    EDITOR_CMD="code"
    echo "✓ Using VS Code as editor"
fi

# Install useful extensions
echo "📦 Installing Cursor/VS Code extensions..."

# General
$EDITOR_CMD --install-extension steoates.autoimport
$EDITOR_CMD --install-extension BeardedBear.beardedtheme
$EDITOR_CMD --install-extension aaron-bond.better-comments
$EDITOR_CMD --install-extension dsznajder.es7-react-js-snippets
$EDITOR_CMD --install-extension christian-kohler.path-intellisense
$EDITOR_CMD --install-extension VisualStudioExptTeam.vscodeintellicode
$EDITOR_CMD --install-extension shd101wyy.markdown-preview-enhanced
$EDITOR_CMD --install-extension quicktype.quicktype
$EDITOR_CMD --install-extension tomoki1207.pdf
$EDITOR_CMD --install-extension unifiedjs.vscode-mdx
$EDITOR_CMD --install-extension adpyke.codesnap
$EDITOR_CMD --install-extension aaron-bond.better-comments
$EDITOR_CMD --install-extension naumovs.color-highlight

# Python
$EDITOR_CMD --install-extension ms-python.python
$EDITOR_CMD --install-extension anysphere.pyright
$EDITOR_CMD --install-extension mgesbert.python-path
$EDITOR_CMD --install-extension charliermarsh.ruff
$EDITOR_CMD --install-extension ms-python.isort
$EDITOR_CMD --install-extension KevinRose.vsc-python-indent
$EDITOR_CMD --install-extension ms-python.mypy-type-checker
$EDITOR_CMD --install-extension ms-python.debugpy

# Web development
$EDITOR_CMD --install-extension mikestead.dotenv
$EDITOR_CMD --install-extension mike-co.import-sorter
$EDITOR_CMD --install-extension bradlc.vscode-tailwindcss
$EDITOR_CMD --install-extension ms-vscode.vscode-json
$EDITOR_CMD --install-extension dbaeumer.vscode-eslint
$EDITOR_CMD --install-extension rvest.vs-code-prettier-eslint
$EDITOR_CMD --install-extension esbenp.prettier-vscode
$EDITOR_CMD --install-extension oven.bun-vscode
$EDITOR_CMD --install-extension dsznajder.es7-react-js-snippets
$EDITOR_CMD --install-extension wix.vscode-import-cost


# Git and version control
$EDITOR_CMD --install-extension eamodio.gitlens
$EDITOR_CMD --install-extension mhutchie.git-graph
$EDITOR_CMD --install-extension donjayamanne.githistory

# Themes and icons
$EDITOR_CMD --install-extension BeardedBear.beardedtheme

# Database
$EDITOR_CMD --install-extension cweijan.vscode-mysql-client2


# Create Cursor/VS Code settings directories
CURSOR_SETTINGS_DIR=~/Library/Application\ Support/Cursor/User/
VSCODE_SETTINGS_DIR=~/Library/Application\ Support/Code/User/

mkdir -p "$CURSOR_SETTINGS_DIR"
mkdir -p "$VSCODE_SETTINGS_DIR"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(dirname "$SCRIPT_DIR")"

# Copy existing settings.json to both Cursor and VS Code
if [ -f "$DOTFILES_ROOT/vscode/settings.json" ]; then
    echo "📋 Copying your custom settings.json..."
    cp "$DOTFILES_ROOT/vscode/settings.json" "$CURSOR_SETTINGS_DIR/settings.json"
    cp "$DOTFILES_ROOT/vscode/settings.json" "$VSCODE_SETTINGS_DIR/settings.json"
    echo "✓ Settings copied to both Cursor and VS Code"
else
    echo "⚠️  No vscode/settings.json found, using default settings"

    # Create default settings if no custom file exists
    cat > "$CURSOR_SETTINGS_DIR/settings.json" << 'EOF'
{
  "editor.fontSize": 14,
  "editor.fontFamily": "JetBrains Mono, Menlo, Monaco, 'Courier New', monospace",
  "editor.fontLigatures": true,
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "editor.detectIndentation": false,
  "editor.wordWrap": "on",
  "editor.minimap.enabled": false,
  "editor.rulers": [80, 120],
  "editor.bracketPairColorization.enabled": true,
  "editor.guides.bracketPairs": true,
  "editor.suggestSelection": "first",
  "editor.formatOnSave": true,
  "editor.formatOnPaste": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true,
    "source.organizeImports": true
  },
  "files.autoSave": "onFocusChange",
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "files.trimFinalNewlines": true,
  "workbench.colorTheme": "Material Theme Darker",
  "workbench.iconTheme": "material-icon-theme",
  "workbench.startupEditor": "newUntitledFile",
  "terminal.integrated.fontSize": 14,
  "terminal.integrated.fontFamily": "JetBrains Mono",
  "git.enableSmartCommit": true,
  "git.autofetch": true,
  "git.confirmSync": false,
  "typescript.updateImportsOnFileMove.enabled": "always",
  "javascript.updateImportsOnFileMove.enabled": "always",
  "emmet.includeLanguages": {
    "javascript": "javascriptreact",
    "typescript": "typescriptreact"
  },
  "prettier.singleQuote": true,
  "prettier.trailingComma": "es5",
  "prettier.printWidth": 80,
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact"
  ]
}
EOF
    
    cp "$CURSOR_SETTINGS_DIR/settings.json" "$VSCODE_SETTINGS_DIR/settings.json"
fi

echo "✓ Cursor/VS Code setup complete!"
echo "✓ Extensions installed"
echo "✓ Settings configured"
echo ""
echo "You may need to restart Cursor/VS Code for all changes to take effect."
