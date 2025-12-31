function js -d "Run jj split until ctrl-c"
    while true
        if test (jj st | head -1) = "The working copy has no changes."
            echo "All Done!"
            break
        end
        jj split 2>/dev/null
        if test $status -ne 0
            break
        end
    end
end
