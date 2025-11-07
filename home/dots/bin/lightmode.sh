#!/usr/bin/env bash

dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
dms ipc theme light
