function repo -d "select ghq repository or get"
    set -l result ''
    set -l dest ''

    # clone repository
    if echo "$argv[1]" | grep -q -E '^(git@|http)'
        ghq get "$argv[1]"
        return
    end

    # change directory by ghq get
    if test -z $argv[1]
        ghq list --unique | peco | read line

        if [ $line ]
            set result $line
        else
            return
        end
    else
        set result $argv[1]
    end

    set dest (ghq list --exact --full-path $result)

    if test "$dest" != ''
        cd $dest
    end
end
