export NVM_DIR="$HOME/.nvm"
export GOPATH="$HOME/go"
export ANDROID_SDK_DIR="$HOME/local/opt/android-sdk"
export ANDROID_NDK_DIR="$HOME/local/opt/android-ndk"
export QT_DIR="$HOME/local/opt/Qt5.7.0"

typeset -U path
path=(~/bin $GOPATH/bin /usr/local/go/bin $path)
