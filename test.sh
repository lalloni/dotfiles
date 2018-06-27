#!/bin/sh
export DEBIAN_FRONTEND=noninteractive
die() {
    echo "FAIL!"
    exit 1
}
cleanup() {
    docker rm -f "$1"
    docker rmi "$1"
    die
}
if [ $# -eq 0 ]; then
    DISTS="14.04 16.04 18.04"
    for DIST in $DISTS; do
        echo "################################################################## Testing in $DIST"
        N="dotfiles-$DIST"
        docker run -ti -v "$PWD/$0:/test.sh" --name "$N" "ubuntu:$DIST" /test.sh prepare || cleanup "$N"
        docker commit "$N" "$N" || cleanup "$N"
        docker rm -f "$N" || cleanup "$N"
        docker run -ti -v "$PWD/$0:/test.sh" --name "$N" "$N" /test.sh run || cleanup "$N"
        docker rm -f "$N"
        docker rmi "$N"
    done
    echo "SUCCESS!"
    exit
fi
if [ "$1" = "prepare" ]; then
    apt update -q
    apt install -yq locales sudo git lsb-release || die
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
