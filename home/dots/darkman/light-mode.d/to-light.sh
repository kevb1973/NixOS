#!/usr/bin/env bash

export PATH="$PATH:/home/kev/bin"
echo "Switching to light mode"
# Set isd to light theme 
# sed -i -e 's/"textual-dark"/"textual-light"/g' ~/dotfiles/isd/.config/isd_tui/config.yaml

# Set DankMaterialShell to light mode
~/Code/dms-bin/dms ipc theme light
# qs -c ~/.config/DMS/ ipc call wallpaper set ~/Pictures/wallpaper/1440p/leafy-dawn.png
