# Dotfiles (macOS)

Super simple Mac setup for developers.

## Install (fresh Mac)
Paste this into Terminal:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/lvndry/dotfiles/master/macos/bootstrap.sh)"
```

It will install Command Line Tools, Homebrew, apps/CLIs from the Brewfile, Oh My Zsh + powerlevel10k, and link your zsh files.

## Add GitHub SSH key
```bash
./ssh/github.sh your-email@example.com personal-mac
```
Add it in GitHub → Settings → SSH and GPG keys. Test:
```bash
ssh -T git@github.com
```
Optional: switch this repo to SSH:
```bash
cd ~/dotfiles
git remote set-url origin git@github.com:lvndry/dotfiles.git
```

## Verify
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

## Files
- `macos/bootstrap.sh` – one-command installer
- `macos/setup.sh` – main setup
- `macos/Brewfile` – apps and CLIs
- `shell/.zshrc`, `shell/.zprofile` – shell config
- `ssh/github.sh`, `ssh/README.md` – SSH helper

