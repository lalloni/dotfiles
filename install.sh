#!/bin/sh

USAGE="$(basename "$0") [options]

Options:
-y      Assume the user answered YES on all confirmation requests
-h      Show this usage help
"

O_YES=0

BASE="$(dirname "$(readlink -f "$0")")"

info() {
    echo ">>> $1"
}

warn() {
    echo "!!! $1"
}

show() {
    echo "    $1"
}

error() {
    echo "err $1"
}

die() {
    error "$1: aborting" >/dev/stderr
    exit 1
}

askYn() {
    if [ $O_YES -eq 1 ]
    then
        return 0
    fi
    while true
    do
        read -p "??? $1 (Y/n) " yn
        case "$yn" in
            y|Y|'')
                return 0
                ;;
            n|N)
                return 1
                ;;
            *)
                warn "You must answer Y or N. Try again."
                ;;
        esac
    done
}

restow() {
    show "re/stowing $1..."
    command stow -R "$1"
}

# Parse arguments
while getopts hy opt; do
    case "$opt" in
        y)
            O_YES=1
            ;;
        h)
            echo "$USAGE"
            exit
            ;;
        \?)
            echo "$USAGE"
            exit 1
            ;;
    esac
done
shift $(($OPTIND - 1))

# Install basic programs
if askYn "Install basic programs?"
then
    info "Installing basic programs..."
    sudo apt install -y \
        ctags \
        htop \
        most \
        parallel \
        pv \
        ranger \
        silversearcher-ag \
        stow \
        vim \
        zsh \
        || die "installing programs"
    info "done."
fi

# Install GUI programs
if askYn "Install GUI programs?"
then
    info "Installing GUI programs..."
    sudo apt install -y \
        rxvt-unicode-256color \
        vim-gtk \
        || die "installing programs"
    info "done."
fi

info "Linking dotfiles in $HOME..."
# Check for stow
if ! which stow >/dev/null; then
    if askYn "Stow not found. Do you want to install it to proceed?"
    then
        sudo apt install -yq stow || die "installing stow"
    else
        die "can't link dotfiles without stow"
    fi
fi
# Link dotfiles
cd "$BASE"
find -maxdepth 1 -type d -not -name '.*' -printf "%P\n" | while read -r d; do
    restow "$d" || die "restowing $d"
done || die "restowing"
info "done."

info "Initializing dotfiles git submodules..."
cd "$BASE" # just in case
git submodule update --init
info "done."

info "Installing vim plugins..."
vim +PluginInstall +qall
info "done."
