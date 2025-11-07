#!/usr/bin/env bash

dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
dms ipc theme dark
