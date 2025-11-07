#!/usr/bin/env sh

# pgrep dms || exit 1

case "$1" in
dark) ~/Code/dms-bin/dms ipc theme dark;;
light)~/Code/dms-bin/dms ipc theme light;;
esac
