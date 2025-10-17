#!/usr/bin/env bash

export PATH="$PATH:/home/kev/bin"
echo "Switching to dark mode"
# Set isd to dark theme 
# sed -i -e 's/"textual-light"/"textual-dark"/g' ~/dotfiles/isd/.config/isd_tui/config.yaml

# Set DankMaterialShell to dark mode
dms ipc theme dark
# qs -c ~/.config/DMS/ ipc call wallpaper set ~/Pictures/wallpaper/1440p/leafy-moon.png
