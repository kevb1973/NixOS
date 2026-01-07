#!/usr/bin/env bash

############################
# Trackman Marble Settings #
############################

# Gnome likes to reset any changes.. wait until gnome starts before setting.
sleep 5


# Set Buttons, button scroll etc.
ID=$(xinput list | grep Trackball | awk '{print $6}'|cut -d "=" -f 2)
echo "The ID is $ID."
#xinput set-button-map $ID 1 8 3 4 5 6 7 2 9
#xinput set-prop $ID "libinput Button Scrolling Button" 3
#xinput set-prop $ID "libinput Button Scrolling Button Lock Enabled" 0
#xinput set-prop $ID "libinput Scroll Method Enabled" 0, 0, 1
#xinput set-prop $ID "libinput Scrolling Pixel Distance" 20
#xinput set-prop $ID "libinput Horizontal Scroll Enabled" 0
#xinput set-prop $ID "libinput Accel Speed" .5
#xinput set-prop $ID "libinput Accel Profile Enabled" 1, 0
xinput set-prop $ID "libinput Scrolling Pixel Distance" 50
