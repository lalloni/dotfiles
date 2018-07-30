if [[ ! -d "~/.sdkman" ]]
then
    echo "Installing sdkman..."
    curl -sSL "https://get.sdkman.io" | bash
fi
restow --no-folding .
