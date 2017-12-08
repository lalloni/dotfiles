# Path to oh-my-zsh
ZSH=$HOME/.oh-my-zsh

# Path of oh-my-zsh customizations
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

# Set name of the theme to load
ZSH_THEME="pilantropy"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Plugins to load
plugins=(
    colored-man-pages
    copybuffer
    dircycle
    dirhistory
    docker
    docker-compose
    fasd
    git
    golang
    httpie
    mvn
    npm
    nvm
    sbt
    scala
    ssh-agent
    systemd
    tmux
    urltools
    zsh-syntax-highlighting
    history-substring-search # must be loaded *after* zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets root)

