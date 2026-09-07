function jsplit -d "Run jj split in NixOS config until ctrl-c"
    while true
        # Check if there are changes remaining
        if test (jj st | head -1) = "The working copy has no changes."
            echo "All Done!"
            break
        end
        jj split -R ~/NixOS/ 2>/dev/null
        # handle 'quit'
        if test $status -ne 0
            echo "Split Cancelled"
            break
        end
    end
end
