function jsplit -d "Run jj split in NixOS config until ctrl-c"
    while true
        # With fish, if there is nothing returned, test will fail
        # string collect makes sure there is a string to test, even if empty
        if test -z (jj diff -R ~/NixOS/ --summary | string collect)
            echo "All Done!"
            break
        end
        jj split -R ~/NixOS/ 2>/dev/null
        if test $status -ne 0
            echo "Split Cancelled"
            break
        end
    end
end
