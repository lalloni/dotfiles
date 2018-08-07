replacehomelink ".nodenv"
if ! (cd ~/.nodenv && src/configure && make -C src)
then
    info "using nodenv not optimized"
fi
