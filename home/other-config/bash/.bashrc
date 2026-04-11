#!/usr/bin/env bash
# ~/.bashrc
#
export PATH=/home/kev/NixOS/home/non-xdg-dots/bin:/home/kev/Code/dms-bin:$PATH
export XDG_DATA_DIRS=/etc/profiles/per-user/kev/bin:$XDG_DATA_DIRS

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias p='yay'
alias arch='distrobox enter arch'
alias h='Hyprland'
alias rb='pushd ~/NixOS && sudo nixos-rebuild switch --flake .# && /home/kev/bin/sysdiff && popd'
alias n='niri --session'
PS1='[\u@\h \W]\$ '
