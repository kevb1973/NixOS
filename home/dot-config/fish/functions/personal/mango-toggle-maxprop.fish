function mango-toggle-maxprop -d "Toggle between full and half-screen in MangoWC"
    set -f current_width (mmsg -g | grep width | awk '{print $3}')
    if test "$current_width" -gt 1270
        mmsg -d set_proportion,.5
    else
        mmsg -d set_proportion,1
    end
end
