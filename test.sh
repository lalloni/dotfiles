#!/bin/sh
export DEBIAN_FRONTEND=noninteractive
die() {
    exit 1
}
if [ $# -eq 0 ]; then
    DISTS="14.04 16.04 18.04"
    for DIST in $DISTS; do
        echo "################################################################## Testing in $DIST"
        N="dotfiles-$DIST"
        docker run -ti -v "$PWD/$0:/test.sh" --name "$N" "ubuntu:$DIST" /test.sh prepare || die
        docker commit "$N" "$N" || die
        docker rm -f "$N" || die
        docker run -ti -v "$PWD/$0:/test.sh" --name "$N" "$N" /test.sh run || die
        docker commit "$N" "$N" || die
        docker rm -f "$N" || die
    done
    exit
fi
if [ "$1" = "prepare" ]; then
    apt-get update
    apt-get install -yq locales sudo git lsb-release || die
    locale-gen --purge en_US.UTF-8 || die
    echo "LANG=\"en_US.UTF-8\"\nLANGUAGE=\"en_US:en\"" > /etc/default/locale
    echo "America/Argentina/Buenos_Aires" > /etc/timezone
    exit
fi
if [ "$1" = "run" ]; then
    export LANG="en_US.UTF-8"
    export LANGUAGE="en_US:en"
    git clone https://github.com/lalloni/dotfiles ~/dotfiles || die
    ~/dotfiles/install.sh || die
    exit
fi
echo "Unknown test phase: $1"
exit 1
