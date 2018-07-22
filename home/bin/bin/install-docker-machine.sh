#!/bin/bash
set -Eeuo pipefail
echo "Downloading docker-machine..."
curl -#Lo "$HOME/bin/docker-machine" https://github.com/docker/machine/releases/download/v0.15.0/docker-machine-$(uname -s)-$(uname -m)
chmod -v +x "$HOME/bin/docker-machine"
#echo "Downloading docker-machine-kvm2..."
#curl -#Lo "$HOME/bin/docker-machine-kvm2" https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2
#chmod -v +x "$HOME/bin/docker-machine-kvm2"
