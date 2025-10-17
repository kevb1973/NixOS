#!/usr/bin/env bash
# ~/.bashrc
#
export PATH=/home/kev/bin:$PATH
# Darkman looks under XDG_DATA_DIRS for dark/light mode scripts
export XDG_DATA_DIRS=/home/kev/.local/share/darkman:$XDG_DATA_DIRS

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias p='yay'
alias arch='distrobox enter arch'
alias h='Hyprland'
alias rb='pushd ~/NixOS && sudo nixos-rebuild switch --flake .# && /home/kev/bin/sysdiff && popd'
alias n='niri --session'
PS1='[\u@\h \W]\$ '

# source /home/kev/.config/broot/launcher/bash/br
