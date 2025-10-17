#!/usr/bin/env bash

notify-send -t 3000 "Playing Video" "$(wl-paste)";
mpv --ytdl-format=bestvideo+bestaudio/best --fs --speed=1.0 --af=rubberband=pitch-scale=0.981818181818181 "$(wl-paste)"
