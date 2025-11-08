function js -d "Run jj split until ctrl-c"
    while true
        jj split
        if test $status
            echo "Nothing to split!"
            break
        end
        snore 2
    end
end
