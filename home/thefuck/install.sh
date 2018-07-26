aptensurepkg virtualenv build-essential python3-dev
if [[ ! -d "$HOME/.py3env" ]]
then
    virtualenv --python=python3 "$HOME/.py3env"
fi
"$HOME/.py3env/bin/pip" install --upgrade thefuck
