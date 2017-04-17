#!/bin/sh

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
    MSG="$1"
    O_YES=$2
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
    command stow -t "$HOME" -R "$1"
}

