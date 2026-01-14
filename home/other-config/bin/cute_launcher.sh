#!/usr/bin/env bash

source /home/kev/Code/cute/cute
cd ~/Documents/silverbullet/Code/commands
app=$(cute -l | fzf)
cute "$app"
