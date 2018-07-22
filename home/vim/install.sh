
# Get vim 8 from PPA if ubuntu version doesn't have it
aptensurepkg lsb-release
if awk "BEGIN { exit 1 - ($(lsb_release -sr) < 17.04) }"
then
    aptaddrepo ppa:jonathonf/vim
fi

# Packages
aptensurepkg vim ctags

# Plugins
info "Installing vim plugins..."
env SHELL=$(which bash) vim +PluginInstall +qall
info "Finished installing vim plugins."
