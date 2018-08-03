for s in /etc/grc.fish source /usr/local/etc/grc.fish
    if test -r $s
        source $s
    end
end
