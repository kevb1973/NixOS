#!/usr/bin/env sh

# Remap buttons for Kensington Slimblade/Marble Mouse Trackball using libinput
# xinput list                  <--find id
# xinput get-button-map id     <--get current button map
# xinput set-button-map id map <--set new button map (see below)

# Other properties can me changed ie. scroll sensitivity, hold-button scrolling etc.
# See Arch-wiki libinput page for more details

# Have to detect current ID as it can change!
# Button map is in order of button number.
# The number for each button represents the action. (left click, right click, scroll up etc)

# Xorg version
ID=$(xinput list | grep Trackball | awk '{print $6}' | cut -d "=" -f 2)
echo "Trackball ID: $ID"
# Wayland version (only works on apps using XWayland)
#ID=$(xinput list | grep xwayland-pointer | awk {print } | cut -d "=" -f 2)

xinput set-button-map $ID 1 8 3 4 5 6 7 2 2
