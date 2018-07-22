#!/bin/bash
set -Eeuo pipefail
GO_VERSION=1.10.3
GORELEASER_VERSION=0.79.1
die() {
    echo "$*" >&2
    exit 1
}
checkpath() {
    if echo "$PATH" | grep -qv "$1"
    then
        echo "ATENCION: Agregar '$1' a \$PATH"
    fi
}
PRE=""
if [[ $UID -ne 0 ]]
then
    if ! which sudo > /dev/null
    then
        die "instalar sudo antes de correr este script"
    fi
    PRE=sudo
fi
which curl > /dev/null || $PRE apt update && apt -yq install curl
if [[ -d /usr/local/go ]] && /usr/local/go/bin/go version | grep -v "$GO_VERSION"
then
    rm -rf /usr/local/go
fi
if [[ ! -d /usr/local/go ]]
then
    echo "Instalando Go..."
    curl -#L "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz" | $PRE tar -xzC /usr/local
fi
mkdir -p "$HOME/go" > /dev/null
echo "Instalando dep..."
curl -#L "https://raw.githubusercontent.com/golang/dep/master/install.sh" | $PRE env INSTALL_DIRECTORY=/usr/local/bin sh
echo "Instalando goreleaser..."
curl -#L "https://github.com/goreleaser/goreleaser/releases/download/v${GORELEASER_VERSION}/goreleaser_Linux_x86_64.tar.gz" | $PRE tar -xzC /usr/local/bin goreleaser
checkpath "/usr/local/bin"
checkpath "$HOME/go/bin"
