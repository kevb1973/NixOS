#!/usr/bin/env sh
# Uses Noctalia dmenu support for shell integrated menu
selection=$(printf \
  "
dwindle
fair
grid
monocle
right-tile
scroller
tile
" | noctalia dmenu -p "Choose Layout")

layout="$(echo "$selection" | awk '{print $1}')"
[ -n "$layout" ] && mmsg dispatch setlayout, "$layout"
