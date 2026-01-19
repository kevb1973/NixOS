function system-theme-toggle
    set -f current_scheme (dconf read /org/gnome/desktop/interface/color-scheme | sed 's/\'//g')
    switch $current_scheme
        case default
            # current theme is light, so switch to dark
            dms ipc theme dark
            # noctalia-shell ipc call darkMode setDark
            dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
            pkill -USR1 -f kitty
        case prefer-dark
            # current theme is dark, so switch to light
            dms ipc theme light
            # noctalia-shell ipc call darkMode setDark
            dconf write /org/gnome/desktop/interface/color-scheme "'default'"
            pkill -USR1 -f kitty
    end
end
