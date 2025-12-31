function nixup
    echo "🗘"
    set -f local_rev (nixos-version --hash | cut -c 1-7)
    set -f remote_rev (git ls-remote https://github.com/NixOS/nixpkgs.git nixos-unstable | cut -c 1-7)

    switch $argv
        case -n
            # For use with systemd timer. Sends notification when update available.
            if test "$local_rev" != "$remote_rev"
                echo "Update Available"
                set -f DBUS_SESSION_BUS_ADDRESS unix:path=/run/user/1000/bus
                notify-send -u normal "Nixpkgs Update Available!" "Revision: $remote_rev"
            else
                echo "No Updates"
            end
        case -w
            # For use with widgets (waybar/DMS). Returns symbol for widget label.
            if test "$local_rev" != "$remote_rev"
                # notify-send -u normal "Nixpkgs Update Available" "Revision: $remote_rev"
                echo "⬆"
            else
                echo "󰸞"
            end
        case '*' # For terminal use with no flags
            if test "$local_rev" = "$remote_rev"
                echo
                echo "       Up to date      "
            else
                echo
                echo "** Update Available **"
            end
            echo ------------------------
            echo "Current Version: $local_rev"
            echo "Latest Version:  $remote_rev"
            echo ------------------------
    end
end
