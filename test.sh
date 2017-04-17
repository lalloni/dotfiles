#!/bin/sh
die() {
    exit 1
}
if [ "$1" != "run" ]; then
    DISTS="zesty xenial trusty"
    for DIST in $DISTS; do
        echo "################################################ Testing in $DIST"
        docker run -ti --rm -v $PWD/$0:/test.sh "ubuntu:$DIST" /test.sh run || die
    done
    exit
fi
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y locales sudo git lsb-release || die
locale-gen --purge en_US.UTF-8 || die
echo "LANG=\"en_US.UTF-8\"\nLANGUAGE=\"en_US:en\"" > /etc/default/locale
echo "America/Argentina/Buenos_Aires" > /etc/timezone
git clone https://github.com/lalloni/dotfiles ~/dotfiles || die
~/dotfiles/install -y || die

