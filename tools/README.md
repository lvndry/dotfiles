# Development Tools

This directory contains various utilities to help set up and configure your development environment.

## Available Tools

### 🔧 System Setup

#### `macos-prefs.sh`
Configures macOS with developer-friendly settings including:
- Dock and Finder preferences
- Safari privacy settings
- Terminal configurations
- System animations and performance
- Application-specific settings

```bash
./tools/macos-prefs.sh
```

### 🐙 Git Configuration

#### `git-setup.sh`
Sets up Git with common configurations:
- Global user settings
- Global gitignore
- Pre-commit hooks
- Credential helpers

```bash
./tools/git-setup.sh
```

### 💻 Development Environments

#### `node-setup.sh`
Installs and configures Node.js development environment:
- fnm (Fast Node Manager)
- Node.js LTS version
- Global packages (bun)
- Project templates

```bash
./tools/node-setup.sh 20  # Install Node.js 20
```

### 🔧 Editor Setup

#### `vscode-setup.sh`
Installs Cursor/VS Code extensions and configures settings:
- Essential extensions for web development
- Language support (Python, Go, Rust, Java, C#)
- Git and productivity tools
- Themes and icons
- Docker and database tools
- Optimized settings for development
- Automatically detects and uses Cursor if available

```bash
./tools/vscode-setup.sh
```

#### `vim-setup.sh`
Installs vim-plug and configures Vim:
- Installs vim-plug plugin manager
- Sets up your vimrc configuration
- Installs useful plugins (fugitive, airline, tagbar, etc.)
- Creates necessary vim directories
- Backs up existing vimrc if present

```bash
./tools/vim-setup.sh
```

#### `raycast-setup.sh`
Installs useful Raycast extensions:
- Development tools (Homebrew, GitHub, Git, Docker, VS Code)
- Productivity tools (Calendar, Reminders, Notes, Clipboard)
- System utilities (Network, Battery, WiFi, Bluetooth)
- Web tools (Search, Wikipedia, Translate, Weather)

```bash
./tools/raycast-setup.sh
```

## Quick Setup

Run all tools at once:

```bash
# System preferences
./tools/macos-prefs.sh

# Git configuration
./tools/git-setup.sh

# Node.js environment
./tools/node-setup.sh

# VS Code setup
./tools/vscode-setup.sh

# Vim setup
./tools/vim-setup.sh

# Raycast setup
./tools/raycast-setup.sh
```

## Prerequisites

- macOS (for macos-prefs.sh)
- Homebrew (for node-setup.sh)
- Cursor or VS Code (for vscode-setup.sh)

## Customization

Each tool can be customized by editing the script files. Most tools include comments explaining what each section does.

## Troubleshooting

### Permission Issues
Some tools require sudo access. You'll be prompted for your password when needed.

### Cursor/VS Code Not Found
Make sure Cursor or VS Code is installed and the `cursor` or `code` command is available in your PATH.

### Homebrew Not Found
Install Homebrew first:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Contributing

Feel free to add new tools or modify existing ones. Please:
1. Add proper error handling
2. Include usage examples
3. Update this README
4. Test on a fresh macOS installation
