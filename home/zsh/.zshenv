export GOPATH="$HOME/go"

typeset -U path
path+=(~/bin $GOPATH/bin /usr/local/go/bin ~/.cargo/bin ~/.krew/bin)

for s in $HOME/.zsh/env.d/*.zsh(N); do
    source "$s"
done

