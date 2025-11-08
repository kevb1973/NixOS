function js -d "Run jj split until ctrl-c"
    while true
        if test (jj st | head -1) = "The working copy has no changes."
            echo "Nothing to split!"
            break
        end
        jj split
        snore 2
    end
end
