function icat # Disply images in terminal
    kitty +kitten icat $argv
end

function arch # Enter Arch distrobox
    distrobox enter arch
end

function funcs # List functions
    grep function ~/.config/fish/functions/functions.fish | sed s/function//g | sort
end

function funcedit # Edit Functions
    hx ~/.config/fish/functions/functions.fish && source ~/.config/fish/functions/functions.fish
end

function store # Visit app location in /nix/store
    cd (realpath (which $argv) | cut -d/ -f1-4)
end

# enable emacs command mode
# function fish_user_key_bindings
# fish_default_key_bindings -M insert
#     fish_vi_key_bindings insert
# end
