# Path to oh-my-zsh
ZSH=$HOME/.oh-my-zsh

# Path of oh-my-zsh customizations
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

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
COMPLETION_WAITING_DOTS="true"

# Plugins to load
plugins=(
    asdf
    aws
    cargo
    colored-man-pages
    command-not-found
    common-aliases
    copybuffer
    dircycle
    dirhistory
    docker
    docker-compose
    fasd
    git
    git-extras
    github
    golang
    gpg-agent
    gradle
    helm
    httpie
    jira
    kubectl
    last-working-dir
    mvn
    npm
    nvm
    pass
    pyenv
    python
    redis-cli
    rust
    rbenv
    sbt
    sdk
    scala
    screen
    ssh-agent
    sudo
    systemd
    taskwarrior
    tmux
    urltools
    vagrant
    vscode
    web-search
    z
    fz # must be loaded *after* z
    zsh-syntax-highlighting
    history-substring-search # must be loaded *after* zsh-syntax-highlighting
)

# setup ssh-agent plugin
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa

source $ZSH/oh-my-zsh.sh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets root)

