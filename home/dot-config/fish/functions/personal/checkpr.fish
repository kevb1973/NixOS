function checkpr
    clear
    # If no param provided, use gum to get PR#
    if test -z $argv
        set -f pr_input (gum input --header="Nixpkgs PR Merge Checker" --placeholder="#123456")
    else
        set -f pr_input $argv
    end

    # Remove hash if it's there
    set pr_number (string replace -r '^#' '' -- $pr_input[1])

    # Pull json data and format/output with jq
    echo -e "\nPull Request #$pr_number - Merged Branches"
    echo "----------------------------------------"
    curl -s -L "https://nixpkgs.molybdenum.software/api/v2/landings/$pr_number" |
        jq -r '.branches[] | "Branch: \(.)"'

    # If being called from script (popup terminal), pause or it will disappear.
    if test -z $argv
        echo; gum choose --header="" exit
    end
end
