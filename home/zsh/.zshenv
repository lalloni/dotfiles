export GOPATH="$HOME/go"

typeset -U path
path=(~/bin $GOPATH/bin /usr/local/go/bin $path)

for s in $HOME/.zsh/env.d/*.zsh(N); do
    source "$s"
done

