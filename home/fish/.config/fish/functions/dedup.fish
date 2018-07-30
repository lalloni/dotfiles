function dedup -d "remove duplicates keeping order"
    set -l seen
    for arg in $argv
        if not contains $arg $seen
            set seen $seen $arg
            echo $arg
        end
    end
end
