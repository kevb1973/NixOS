#!/usr/bin/env bash

# Set default option to --at-pointer
# Note: Submenus defined at bottom under ^tag()
# Place sub-menu using checkout(), so if you want a sub-submenu, place checkout() in a submenu definition.
# Prepend $DB to anything that runs in arch linux distrobox
DB="distrobox enter arch --"

OPTS="--at-pointer"
TERMINAL="kitty -e"
if [ ! -z "$1" ]; then
	if [[ $1 == "-c" ]]; then
		OPTS="--center"
		echo "Placement set to center."
	fi
fi

(
	printf "Firefox,firefox\n"
	printf "Anydesk,anydesk\n"
	printf "Obsidian,obsidian\n"
	printf "Terminal,kitty\n"
    printf "Audio Mixer,$TERMINAL ncpamixer\n"
	printf "Calculator,speedcrunch\n"
    printf "Hodoku, ~/bin/hodoku-dark\n"
	printf "TV Remote,lgtv_remote.sh\n"
	printf "File Manager,thunar\n"
	printf "Connect to Sam,anydesk 10.0.0.40:7070 --fullscreen\n"
	printf "Kill Anydesk,pgrep --full "anydesk" | xargs kill -9\n"
	printf "Kill Kodi,pgrep --full "kodi" | xargs kill -9\n"
	printf "TV,^checkout(3)\n"
	printf "Power,^checkout(1)\n"
	printf "Configs,^checkout(2)\n"
	printf "^tag(1)\n"
	# printf "Monitor Off,hyprctl dispatch dpms off\n"
	printf 'Monitor Off,swaymsg "output * dpms off"\n'
	
	printf "Reboot, systemctl reboot\n"
	printf "Suspend, systemctl suspend\n"
	printf "Shutdown, systemctl poweroff\n"
	printf "^tag(2)\n"
	printf "rc.fish,kitty -e hx ~/.config/fish/conf.d/rc.fish\n"
	printf "i3.conf,kitty -e hx ~/.config/i3/config\n"
	printf "polybar,kitty -e hx ~/.config/polybar/config.ini\n"
	printf "polybar,kitty -e sudo hx /etc/nixos/configuration.nix\n"
	printf "Edit Menu,kitty -e hx ~/bin/jgmenu_kev.sh\n"
	printf "^tag(3)\n"
	printf "Power On, lgtv wakeonlan\n"
	printf "Power Off, lgtv system turnOff\n"
	printf "Mute On, lgtv audio setMute true\n"
	printf "Mute Off, lgtv audio setMute false\n"
	
) | jgmenu --simple $OPTS


