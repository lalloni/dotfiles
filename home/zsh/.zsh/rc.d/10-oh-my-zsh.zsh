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
    alias-finder
    ant
    asdf
    aws
    bazel
    bgnotify
    cargo
    catimg
    colored-man-pages
    command-not-found
    common-aliases
    copybuffer
    cp
    dircycle
    direnv
    dirhistory
    docker
    docker-compose
    fasd
    gcloud
    git
    git-extras
    gitfast
    github
    golang
    gpg-agent
    gradle
    helm
    history-substring-search
    httpie
    jira
    kubectl
    last-working-dir
    microk8s
    minikube
    mosh
    mvn
    nmap
    node
    npm
    nvm
    otp
    pass
    pyenv
    python
    redis-cli
    ripgrep
    rsync
    rust
    rustup
    rbenv
    #safe-paste
    sbt
    sdk
    scala
    screen
    sprunge
    ssh-agent
    sudo
    svn
    systemd
    #taskwarrior
    terraform
    thefuck
    tmux
    urltools
    vagrant
    web-search
    z
    fz # must be loaded *after* z
    zsh-syntax-highlighting
    history-substring-search # must be loaded *after* zsh-syntax-highlighting
    zsh_reload
)

# setup ssh-agent plugin
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa

source $ZSH/oh-my-zsh.sh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets root)

ZSH_TMUX_AUTOCONNECT=false
