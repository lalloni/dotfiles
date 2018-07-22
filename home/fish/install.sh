
# Get fish 2.x from PPA if ubuntu version doesn't have it
aptensurepkg lsb-release
if awk "BEGIN { exit 1 - ($(lsb_release -sr) < 18.04) }"
then
    aptaddrepo ppa:fish-shell/release-2
fi

# Packages
aptensurepkg fish

# Install fish plugins
info "Installing fish plugins..."
fish -c "fisher"
info "Finished installing fish plugins."

# Setup fish configuration
info "Configuring fish..."
if which vim >/dev/null
then
    fish -c 'set -Ux EDITOR (which vim)'
fi
if which most >/dev/null
then
    fish -c 'set -Ux PAGER (which most)'
fi
if [[ -d "$HOME/go" ]]
then
    fish -c 'set -Ux GOPATH $HOME/go'
    fish -c 'set -U fish_user_paths $GOPATH/bin $fish_user_paths'
fi
fish -c 'set -U fish_user_paths $HOME/bin $fish_user_paths'
fish -c 'set -Ux FZF_COMPLETE 1'
fish -c 'set -Ux FZF_DEFAULT_OPTS "--height 40%"'
fish -c 'set -Ux FZF_LEGACY_KEYBINDINGS 0'
fish -c 'set -Ux FZF_TMUX_HEIGHT "40%"'
info "Finished configuring fish."