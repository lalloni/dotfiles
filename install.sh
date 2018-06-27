#!/bin/bash
set -Eeuo pipefail

BASE="$(dirname "$(readlink -f "$0")")"
NAME="$(basename "$0")"
USAGE="Usage: $NAME [options]

Options:
    --no-packages       Omit OS packages installation
    --no-vim-plugins    Omit VIM plugins installation
    --no-link           Omit linking files to home
    --debug             Enable debug mode
    --help / -h         Show this usage help"

debug() {
    if [[ "$O_DEBUG" = true ]]; then
        echo "*** $*"
    fi
}

info() {
    echo "··· $1"
}

show() {
    echo "    $1"
}

error() {
    echo "××× $1"
}

die() {
    error "$*"
    exit 1
}

restow() {
    show "re/stowing $1..."
    command stow -t "$HOME" -R "$1"
}

OPTS="$(getopt -o h -l help,no-packages,no-vim-plugins,no-link,debug -n "$NAME" -- "$@")"
if [[ $? -ne 0 ]]
then
    die "Invalid command options.\n$USAGE"
    exit 1
fi

O_DEBUG=false
O_PACKAGES=true
O_VIMPLUGINS=true
O_LINK=true

while true
do
    if [[ $# -eq 0 ]]
    then
        break
    fi
    case "$1" in
        -h|--help) echo "$USAGE"; exit 0;;
        --debug) O_DEBUG=true;;
        --no-packages) O_PACKAGES=false;;
        --no-vimplugins) O_VIMPLUGINS=false;;
        --no-link) O_LINK=false;;
        --) break;;
        *) die "Invalid option: '$1'\n$USAGE";;
    esac
    shift
done

debug "Using options:
  » print debug information:    $O_DEBUG
  » install packages:           $O_PACKAGES
  » install vim plugins:        $O_VIMPLUGINS
  » link home files:            $O_LINK
"

info "Initializing dotfiles git submodules..."
cd "$BASE"
git submodule update --init --recursive
info "done."

# Install packages
if [[ $O_PACKAGES == true ]]
then
    info "Installing basic programs..."

    if awk "BEGIN { exit 1 - ($(lsb_release -sr) < 17.04) }"
    then
        # to get vim 8 from PPA
        sudo apt install -yq software-properties-common
        sudo add-apt-repository -y ppa:jonathonf/vim
    fi

    sudo apt update

    sudo apt install -yq \
        ctags \
        curl \
        htop \
        most \
        parallel \
        pv \
        ranger \
        silversearcher-ag \
        stow \
        tmux \
        unzip \
        vim \
        zsh \
        zip

    info "done."
fi

# Link dotfiles
if [[ $O_LINK == true ]]
then
    info "Linking dotfiles in $HOME..."

    # Check for stow
    if ! which stow >/dev/null
    then
        if [[ $O_PACKAGES == true ]]
        then
            sudo apt install -yq stow
        else
            die "stow is not installed and I was run with --no-packages option"
        fi
    fi

    # Link dotfiles
    cd "$BASE/home"
    find -maxdepth 1 -type d -not -name '.*' -printf "%P\n" | \
    while read -r d
    do
        restow "$d"
    done

    info "done."
fi

# Install vim plugins
if [[ $O_VIMPLUGINS == true ]]
then
    info "Installing vim plugins..."
    vim +PluginInstall +qall
    info "done."
fi
