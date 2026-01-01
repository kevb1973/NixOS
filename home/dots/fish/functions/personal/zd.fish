function zd
    set -f path (zoxide query -i -- $argv)
    test $path; and zoxide remove $path
end
