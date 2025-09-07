export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  brew
  macos
  fzf
  zoxide
  zsh-autosuggestions
  zsh-syntax-highlighting
  colored-man-pages
  extract
  gh
  you-should-use
  docker
  node
  npm
  yarn
  web-search
  bat
)

source $ZSH/oh-my-zsh.sh

# Load powerlevel10k config if present
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

export VISUAL='vim'
export EDITOR='vim'

# Come and go - execute command in directory then return
function cag() {
  if [ $# -lt 2 ]; then
    echo "Usage: cag <folder> <command>"
    echo "Example: cag /path/to/project 'npm run build'"
    return 1
  fi
  
  local target_dir="$1"
  shift  # Remove first argument, leaving the command
  
  # Check if directory exists
  if [ ! -d "$target_dir" ]; then
    echo "Error: Directory '$target_dir' does not exist"
    return 1
  fi
  
  # Store current directory
  local original_dir="$(pwd)"
  
  # Change to target directory
  cd "$target_dir" || return 1
  
  # Execute the command
  echo "Executing in $(pwd): $*"
  "$@"
  local exit_code=$?
  
  # Return to original directory
  cd "$original_dir"
  
  return $exit_code
}

function mkcd() {
  mkdir -p "$@" && cd "$@"
}

function gurl() {
  local remotename="${@:-origin}"
  local remote="$(git remote -v | awk '/^'"$remotename"'.*\(push\)$/ {print $2}')"
  [[ "$remote" ]] || return
  local host="$(echo "$remote" | perl -pe 's/.*@//;s/:.*//')"
  local user_repo="$(echo "$remote" | perl -pe 's/.*://;s/\.git$//')"
  echo "https://$host/$user_repo"
}

## Aliases
alias vb='vim ~/.zshrc'
alias sb='source ~/.zshrc'
alias rmr='rm -rf'
alias nr='npm run'
alias iii='npm i'
alias bi='bun i'
alias giti='git init && touch .gitignore'
alias mkcd='mkcd'
alias gurl='gurl'
alias please='sudo $(fc -ln -1)'

alias ll='eza -la'
alias lt='eza -T'
alias cat='bat'
alias grep='rg'
alias find='fd'
alias top='btm'
alias ps='procs'
alias df='duf'

## Path
export PATH="$PATH:$HOME/.local/bin"

# Faster completion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

## SSH
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval "$(ssh-agent -s)" >/dev/null
  for key in ${HOME}/.ssh/id_*; do
    if [ -f "$key" ] && grep -q "PRIVATE" "$key"; then
      ssh-add "$key" >/dev/null 2>&1 || true
    fi
  done
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Homebrew-sourced extras
if command -v brew >/dev/null 2>&1; then
  BREW_PREFIX="$(brew --prefix)"
  [ -f "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ] && source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
  [ -f "$BREW_PREFIX/opt/fzf/shell/completion.zsh" ] && source "$BREW_PREFIX/opt/fzf/shell/completion.zsh"
  [ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

## Zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

## Direnv
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi
