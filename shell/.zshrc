# Path to oh-my-zsh installation.
export ZSH="/home/lvndry/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# PATH
export PATH=$PATH:~/bin

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  archlinux
  git
  sublime
  compleat
  copyfile
  extract
  npm
  perms
  sudo
  web-search
  yarn
 )

if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  for key in ${HOME}/.ssh/id_*; do
    if grep -q PRIVATE "$key"; then
        ssh-add "$key"
    fi
done
fi

source $ZSH/oh-my-zsh.sh
source $HOME/.cargo/env

# Streamroot NPM
export GOPATH="$HOME/go"
export NPMRC=$(cat ~/.npmrc)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export VISUAL='vim'

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Custom functions
 func mkcd() {
	 mkdir -p "$@" && cd "$@"
 }

tre() { command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null; }

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# aliases
alias cdgo="cd ~/go/src/github.com"
alias vb="vim ~/.zshrc"
alias sb="source ~/.zshrc"
alias a="atom"
alias ggt="cd ~/Github"
alias rmr="rm -rf"
alias pb="cd ~/Github/publicbloc"
alias pbb="cd ~/Github/publicbloc/blockchain"
alias pbf="cd ~/Github/publicbloc/publicbloc-front"
alias nr="npm run"
alias iii="npm i"
alias giti="git init && touch .gitignore"
alias uppac="sudo pacman -Syyu"
alias remv='sudo pacman -Rnscd'
alias gohome='cd /home/lvndry/go/src/github.com/'
alias mkcd='mkcd'
alias tor='sudo chroot --userspec=tor:tor /opt/torchroot /usr/bin/tor'
alias please='sudo $(fc -ln -1)'
alias serve='http-server'
alias epita="ggt && cd epita"
alias streamroot="ggt && cd streamroot"
alias strt="streamroot"
alias vim-install="vim +PluginInstall +qall"
alias lock='betterlockscreen -l dim'
alias sublime="sublime-text"
alias gta='git tag -a'
alias gpt='git push --follow-tags'
alias code='code'
alias spotify='spotify &'
alias gccf='gcc -Wall -Werror -Wextra -pedantic -std=c99'
alias gccd='gcc -Wall -Werror -Wextra -pedantic -std=c99 -g'

# precmd() { print ">" }
# export PROMPT=""
prompt_newline() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "\%{\%k\%F{$CURRENT_BG}\%}$SEGMENT_SEPARATOR
\%{\%k\%F{blue}\%}$SEGMENT_SEPARATOR"
  else
    echo -n "\%{\%k\%}"
  fi

  echo -n "\%{\%f\%}"
  CURRENT_BG=''
}

build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_context
  prompt_dir
  prompt_git
  prompt_hg
  prompt_newline
  prompt_end
}
