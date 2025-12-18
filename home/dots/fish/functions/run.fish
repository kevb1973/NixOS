function run
    cd ~/NixOS/home/dots/cute/Code || exit
    cute "$(cute -l | fzf)"
end
