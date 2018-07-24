aptensurepkg virtualenv python3-dev
if [[ ! -d "$HOME/.py3env" ]]
then
    virtualenv --python=python3 "$HOME/.py3env"
fi
"$HOME/.py3env/bin/pip" install --upgrade thefuck
ln -fsv "$HOME/.py3env/bin/fuck" "$HOME/bin/"
ln -fsv "$HOME/.py3env/bin/thefuck" "$HOME/bin/"
