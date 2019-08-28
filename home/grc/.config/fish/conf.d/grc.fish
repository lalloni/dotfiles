if test -r /etc/grc.fish
    source /etc/grc.fish
    for executable in $grc_plugin_execs
        if type -q $executable
            alias $executable "grc --colour=auto $executable"
        end
    end
end
