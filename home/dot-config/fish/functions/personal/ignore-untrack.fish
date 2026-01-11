function ignore-untrack --description "Ignore/untrack new files in jj repo"
    cd ~/NixOS
    # check if there are untracked files
    if test (jj status | grep '^A ')
        # use gum to select files to ignore/untrack
        set -f selected_files (jj status | grep '^A.*' | gum choose --header "Add to .gitignore" --no-limit | sed 's/^..//')
        if test $selected_files
            # add selected files to .gitignore and then untrack
            echo "$selected_files"
            # tee -a .gitignore | xargs jj file untrack
        end
    else
        echo "\nNo untracked files found"
    end
end
