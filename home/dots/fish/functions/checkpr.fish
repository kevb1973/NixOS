function checkpr
    if test -n "$argv"
        # collect results for specified PR and format with jq
        nu -c "curl -s -L https://nixpkgs.molybdenum.software/api/v2/landings/$argv | from json"
    else
        echo "Please enter a PR number without '#'"
    end
end
