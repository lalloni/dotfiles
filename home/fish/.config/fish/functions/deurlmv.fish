function deurlmv -d "url decode its arguments and try to mv files to the resulting names"
    set -l a
    for arg in $argv
        set a (deurl "$arg")
        if test -n "$a" -a "$a" != "$arg"
            mv -v "$arg" "$a"
        end
    end
end
