function y
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file=$tmp

    # Read the cwd file (handles paths with spaces/newlines safely)
    set -l cwd (cat $tmp)

    if test "$cwd" != "$PWD" -a -d "$cwd"
        builtin cd $cwd
    end

    rm -f $tmp
end
