#!/bin/bash
set -Eeuo pipefail
echo "Downloading minikube..."
curl -#Lo "$HOME/bin/minikube" https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod -v +x "$HOME/bin/minikube"
