replacehomelink ".nodenv"
restow --no-folding "."
if ! (cd ~/.nodenv && src/configure && make -C src)
then
    info "using not-optimized nodenv"
fi
