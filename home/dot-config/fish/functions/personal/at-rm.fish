function at-rm -d "Interactively select and remove 'at' jobs using fzf with command preview"
    set -l jobs_raw (atq)
    if test (count $jobs_raw) -eq 0
        echo "No jobs in at queue."
        return 0
    end

    # Sort by scheduled time: year → month → day → time → job#
    # Fields: 1=job, 2=weekday, 3=month, 4=day, 5=time, 6=year, 7=queue, 8=user
    set -l jobs (string join \n $jobs_raw \
        | sort -k6,6n -k3,3M -k4,4n -k5,5 -k1,1n)

    # Preview: last non-empty line from at -c
    set -l preview_cmd '\
        line=$(echo {} | sed "s/^[[:space:]]*//;s/[[:space:]]*$//"); \
        id=$(echo "$line" | awk "{print \$1}" | grep -E "^[0-9]+$" || echo ""); \
        if [ -n "$id" ]; then \
            cmd=$(at -c "$id" 2>/dev/null | awk "NF > 0" | tail -n 1); \
            if [ -n "$cmd" ]; then \
                echo "$cmd" | fold -w 80 -s; \
            else \
                echo "(no non-empty command found)"; \
            fi; \
        else \
            echo "Could not extract job ID from: $line"; \
        fi'

    set -l selected (string join \n $jobs | fzf --multi --height=~60% --border \
        --prompt="Select jobs to REMOVE (tab to multi-select) — sorted by soonest first: " \
        --preview="$preview_cmd" \
        --preview-window=down:5:wrap)

    if test -z "$selected"
        return 0
    end

    set -l to_remove
    for line in $selected
        set -l normalized (string trim -- (string replace -a -r '\s+' ' ' -- $line))
        set -l parts (string split ' ' -- $normalized)

        if test (count $parts) -ge 2
            set -l id $parts[1]
            set -l when (string join ' ' $parts[2..-1])
            if string match -qr '^[0-9]+$' -- $id
                set -a to_remove "$id  →  $when"
            end
        end
    end

    if test (count $to_remove) -eq 0
        echo "No valid jobs selected / parsed."
        return 1
    end

    echo "About to remove the following jobs:"
    for entry in $to_remove
        echo "  $entry"
    end
    echo

    read -P "Confirm deletion? [y/N] " confirm
    switch (string lower $confirm)
        case y yes
            for entry in $to_remove
                set -l id (string split ' ' -- $entry)[1]
                if at -d $id 2>/dev/null
                    echo "Deleted job $id"
                else
                    echo "Failed to delete job $id"
                end
            end
        case '*'
            echo "Cancelled."
    end
end
