setopt extendedglob null_glob

autoload zmv
autoload zcalc

case "$TERM" in
    xterm) TERM=xterm-256color;;
    screen) TERM=screen-256color;;
esac
export TERM

export PAGER=most
export EDITOR=vim

