# Dotfiles (macOS)

Super simple Mac setup for developers.

## Install (fresh Mac)
Paste this into Terminal:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/lvndry/dotfiles/master/macos/bootstrap.sh)"
```

It will install Command Line Tools, Homebrew, apps/CLIs from the Brewfile, Oh My Zsh + powerlevel10k, and link your zsh files.

## Verify installation
Open a new terminal (powerlevel10k should load), then:
```bash
brew --version
node -v; bun -v; uv --version
fzf -v; zoxide -V; direnv version
```

## Customize
- Edit `shell/.zshrc` (plugins, aliases)
- Edit `macos/Brewfile` and run `cd macos && brew bundle`
- Run `p10k configure` to style your prompt

## 🧰 Tools

### SSH Tools
- [Add and create a SSH Key to your Github account](https://github.com/lvndry/dotfiles/tree/master/ssh)

### Development Tools
- [Development Tools](https://github.com/lvndry/dotfiles/tree/master/tools) - Complete development environment setup

**Available Scripts:**
- `tools/macos-prefs.sh` - Configure macOS with developer-friendly settings
- `tools/git-setup.sh` - Set up Git with aliases, global config, and hooks
- `tools/node-setup.sh` - Install Node.js with fnm, bun, and development tools
- `tools/vscode-setup.sh` - Install Cursor/VS Code extensions and configure settings
- `tools/vim-setup.sh` - Install Vundle and configure Vim with plugins

**Quick Setup:**
```bash
./tools/macos-prefs.sh
./tools/git-setup.sh
./tools/node-setup.sh
./tools/vscode-setup.sh
./tools/vim-setup.sh
./ssh/github.sh
```
