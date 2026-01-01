function sn
    clear

    # Note: 'default' search type is currently broken in nix-search-cli. created github issue.
    # when fixed, add default to gum filter command below.

    set -f TYPE (gum filter name description program)
    if test -z "$TYPE"
        then echo 'search cancelled'
        exit
    end

    if test -n "$argv"
        set -f QUERY $argv
    else
        set -f QUERY (gum input --placeholder='Search Term')
    end

    if test -z "$QUERY"
        then echo 'search cancelled'
    end

    echo "Searching $TYPE for '$QUERY'"

    switch "$TYPE"
        case default
            nix-search -r -d -s "$QUERY" --json >/tmp/nix-search-results.json
        case name
            nix-search -r -d -n "$QUERY" --json >/tmp/nix-search-results.json
        case description
            nix-search -r -d -q "package_description:($QUERY)" --json >/tmp/nix-search-results.json
        case program
            nix-search -r -d -p "$QUERY" --json >/tmp/nix-search-results.json
    end
    tv nix-search
end
