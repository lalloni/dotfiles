#!/bin/sh

die() {
    echo "error: $1: aborting" >/dev/stderr
    exit 1
}

restow() {
    echo "(re)stowing $1..."
    command stow -R "$1" || die "stowing $1"
}

BASE="$(dirname "$(readlink -f "$0")")"

# Install (optionally basic tools)
read -p "Install basic programs? (Y/n)" yn
case "$yn" in
    y|Y|'')
        # Install programs
        sudo apt install -yq ranger htop most stow silversearcher-ag vim zsh
        ;;
esac

# Check for stow
if ! which stow >/dev/null; then
    read -p "Stow not found. Do you want to install it? (Y/n)" yn
    case "$yn" in
        y|Y|'')
            sudo apt install -yq stow || die "installing stow"
            ;;
        *)
            echo "can't link dotfiles without stow"
            exit 0
            ;;
    esac
fi

# Link dotfiles
cd "$BASE"
find -maxdepth 1 -type d -not -name '.*' -printf "%P\n" | while read -r d; do
    restow "$d"
done

# Install vim plugins
vim +PluginInstall +qall
