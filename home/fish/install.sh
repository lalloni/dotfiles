# Link everything from $HOME
restow --no-folding .

# Get fish 2.x from PPA if ubuntu version doesn't have it
aptensurepkg lsb-release
if awk "BEGIN { exit 1 - ($(lsb_release -sr) < 18.04) }"
then
    aptaddrepo ppa:fish-shell/release-3
fi

# Packages
aptensurepkg fish grc

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
    fish -c 'set -U fish_user_paths (dedup $GOPATH/bin $fish_user_paths)'
fi
fish -c 'set -U fish_user_paths (dedup $HOME/bin $fish_user_paths)'
fish -c 'set -Ux FZF_COMPLETE 3'
fish -c 'set -Ux FZF_DEFAULT_OPTS "--height 50%"'
fish -c 'set -Ux FZF_LEGACY_KEYBINDINGS 0'
fish -c 'set -Ux FZF_TMUX_HEIGHT "50%"'
info "Finished configuring fish."
