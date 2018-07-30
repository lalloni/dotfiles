#!/bin/bash

#set -x # uncomment for debugging
set -Eeuo pipefail

BASE="$(dirname "$(readlink -f "$0")")"
NAME="$(basename "$0")"
USAGE="Usage: $NAME [options]

Options:
    --no-packages       Omit OS packages installation
    --local             Omit all installations
                        (i.e. --no-packages --no-vimplugins --no-fishplugins)
    --no-link           Omit dotfiles linking
    --debug             Enable debug mode
    --help / -h         Show this usage help"

if [[ $(id -u) -ne 0 ]]
then
    SUDO="sudo"
else
    SUDO=""
fi

APT_REPOS_NEED_UPDATE="yes"

out() {
    echo "················>" "$@"
}

debug() {
    if [[ "$O_DEBUG" == true ]]; then
        out "debug: $*"
    fi
}

info() {
    out "info: $@"
}

show() {
    out "show: $@"
}

error() {
    out "error: $@"
}

die() {
    error "$@"
    exit 1
}

aptaddrepo() {
    if ! dpkg -l software-properties-common &>/dev/null
    then
        $SUDO apt install -yq software-properties-common
    fi
    if ! apt-cache policy | awk '/http:/{print  $2 $3}' | sort -u | grep -q "${1#ppa:}"
    then
        apt-add-repository -y "$1"
    fi
    APT_REPOS_NEED_UPDATE="yes"
}

aptupdate() {
    if [[ $APT_REPOS_NEED_UPDATE == yes ]]
    then
        $SUDO apt update -q
    fi
    APT_REPOS_NEED_UPDATE="no"
}

aptinstall() {
    aptupdate
    $SUDO apt install -yq $*
}

aptensurepkg() {
    local need=""
    for p in $*
    do
        if ! dpkg -s $p &>/dev/null
        then
           need="$need $p"
        fi
    done
    if [[ -n "$need" ]]
    then
        aptinstall $need
    fi
}

restow() {
    info "Stowing $1 into $HOME..."
    command stow --ignore='install.sh' -t "$HOME" -R "$@"
    info "Finished stowing $1."
}

replacehomelink() {
    if [[ -e "$HOME/$1" ]]
    then
        rm -rf "$HOME/$1"
    fi
    local PARENT="$(dirname "$HOME/$1")"
    if [[ ! -d "$PARENT" ]]
    then
        mkdir -p "$PARENT"
    fi
    ln -rs "$1" "$HOME/$1"
}

replacehomelinks() {
    for l in "$@"
    do
        replacehomelink "$l"
    done
}

OPTS="$(getopt -o h -l help,local,no-packages,no-vimplugins,no-link,debug -n "$NAME" -- "$@")"
if [[ $? -ne 0 ]]
then
    die "Invalid command options."$'\n'"$USAGE"
    exit 1
fi

export O_DEBUG=false
export O_PACKAGES=true
export O_LINK=true

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
        --no-link) O_LINK=false;;
        --) break;;
        *) die "Invalid option: $1"$'\n'"$USAGE";;
    esac
    shift
done

debug "
Using options:
  » print debug information:    $O_DEBUG
  » install packages:           $O_PACKAGES
  » link home files:            $O_LINK
"

info "Ensuring git is installed..."
aptensurepkg git
info "Finished ensuring git is installed."

info "Initializing dotfiles git submodules..."
cd "$BASE"
git submodule update --init --recursive
info "Finished initializing dotfiles git submodules."

# Install packages
if [[ $O_PACKAGES == true ]]
then
    info "Installing programs..."

    aptensurepkg \
        curl \
        htop \
        most \
        parallel \
        pv \
        ranger \
        silversearcher-ag \
        stow \
        sudo \
        tmux \
        unzip \
        zsh \
        zip

    info "Finished installing programs."
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
            aptensurepkg stow
        else
            die "Stow is not installed and I was run with --no-packages option"
        fi
    fi

    # Link dotfiles
    cd "$BASE/home"
    mapfile -t PROCESS < <(find -maxdepth 1 -type d -not -name '.*' -printf "%P\n" | sort -f)
    info "Directories to process: ${#PROCESS[@]}"
    for DIR in "${PROCESS[@]}"
    do
        info ">>> Processing home/$DIR..."
        if [[ -x "$DIR/install.sh" ]]
        then
            info "  · Running install script $DIR/install.sh..."
            pushd "$DIR" > /dev/null
            source "./install.sh"
            popd > /dev/null
            info "  · Finished running install script $DIR/install.sh."
        else
            info "  · Restowing $DIR into $HOME..."
            restow "$DIR"
            info "  · Finished restowing $DIR."
        fi
        info "<<< Finished processing home/$DIR."
        cd "$BASE/home" # just in case
    done

    info "Finished linking dotfiles in $HOME."
fi
