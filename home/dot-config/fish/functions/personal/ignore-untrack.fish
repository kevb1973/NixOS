function ignore-untrack --description "Ignore/untrack new files in jj repo"
    cd ~/NixOS
    # check if there are untracked files
    set -f untracked_files (jj status | grep '^A ')
    if test -n "$untracked_files"
        # use tv to select files to ignore/untrack
        set -f selected_files "$(tv jj-new)"
        if test -n "$selected_files"
            # add selected files to .gitignore and then untrack
            echo -------------------------------------
            echo "Ignore/Untrack the following files?"
            echo -------------------------------------
            echo "$selected_files"
            gum confirm && echo "$selected_files" | tee -a .gitignore | xargs jj file untrack
        end
    else
        echo ------------------------
        echo "No untracked files found"
        echo ------------------------
    end
end
