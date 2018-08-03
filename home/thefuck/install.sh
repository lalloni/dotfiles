aptensurepkg virtualenv build-essential
if [[ ! -d "$HOME/.py3env" ]]
then
    virtualenv --python=python3 "$HOME/.py3env"
fi
"$HOME/.py3env/bin/pip" install -U thefuck
ln -frs "$HOME/.py3env/bin/fuck" "$HOME/bin/"
ln -frs "$HOME/.py3env/bin/thefuck" "$HOME/bin/"
