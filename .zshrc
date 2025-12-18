# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
ZSH_NVM_AUTOLOAD=true
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="oxide"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zoxide zsh-autosuggestions nvm)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
#
### --- Custom Aliases ---

alias zj="zellij -l welcome"
alias ror="bin/rails"
alias zshrc="nvim ~/.zshrc"
alias vimrc="nvim ~/.config/nvim/init.vim"
alias vim="nvim"
alias exr="exercism"
alias uiup="pnpm up -L @1edtech/ui"
alias usedev="gcloud container clusters get-credentials dev --zone us-central1-a --project pnicholls-211415"
alias usetest="gcloud container clusters get-credentials qa --zone us-central1-a --project ankur-playground"
alias usestaging="gcloud container clusters get-credentials staging --zone us-central1-a --project staging-1edtech"
alias useprod="gcloud container clusters get-credentials prod --zone us-central1-a --project orc-project-200112"
alias cat="bat"
alias rmg="rails db:migrate"
alias dbpass="cryptcat $HOME/code/1edtech/db_passwords.txt.gpg"
alias cardcount="$HOME/scripts/push_counts.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# nvmrc loader
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc


### --- Custom Functions ---
#

tt() { # time travel
    history | grep "$1"
}
grune() {
    git fetch --prune && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
}

eradik8(){
    kubectl get pods | grep -E "^"$1"-\w+-\w+ " | cut -d " " -f 1 | xargs kubectl delete pod
}

medik8(){
    kubectl get pods | grep -E "^"$1"-\w+-\w+ " | cut -d " " -f 1 | xargs kubectl logs --follow
}

indik8(){
    kubectl get pods | grep -E "^"$1"-\w+-\w+ " | cut -d " " -f 1 | xargs kubectl describe pod
}


mkdir() {
    command mkdir -p "$@" && cd "$_";
}

gmit(){
    git commit -am "$1"
}

gush(){
    git commit -am "$1" && git push
}

glone(){
    git clone "$1" && cd "$(basename "$1" .git)"
}

pullall(){
    ls | xargs -P10 -I{} git -C {} pull
}

req(){
    curl -X GET $1 | jq
}

dockerkill(){
    docker stop $(docker ps -aq) || true
    docker rm $(docker ps -aq) || true
    docker volume rm $(docker volume ls -q) || true
}

cryptcat(){
    gpg -d $1 | bat -l yaml
}

export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-15.jdk/Contents/Home

export PATH="$JAVA_HOME/bin:$HOME/.luarocks/bin:$HOME/.emacs.d/bin:$PATH"
alias config='/usr/bin/git --git-dir=/Users/jackson/.cfg/ --work-tree=/Users/jackson'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jackson/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jackson/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jackson/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jackson/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home)


# Zellij auto attach
if [[ -z "$ZELLIJ" ]] && [[ -z "$SSH_CONNECTION"  ]]  ; then
  if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
      zellij attach -c
  else
      zellij -l welcome
  fi

  if [[ "$ZELLIJ_AUTO_EXIT" == "TRUE" ]]; then
      exit
  fi
fi

# pnpm
export PNPM_HOME="/Users/jackson/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"



export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export STM32CubeMX_PATH=/Applications/STMicroelectronics/STM32CubeMX.app/Contents/Resources
eval "$(starship init zsh)"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/3.4.0:$PATH"
export PATH="$PATH:$(gem environment gemdir)/bin"

. "$HOME/.local/bin/env"

GPG_TTY=`tty`
export GPG_TTY

# Added by Windsurf
export PATH="/Users/jackson/.codeium/windsurf/bin:$PATH"
export PATH="$HOME/bin:$PATH"
eval "$(jenv init -)"
