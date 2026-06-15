#!/usr/bin/env bash
# atrm $(atq | cut -f1)
# Setup reminder notifications

echo "flake-update-check" | at 8:00am
echo "flake-update-check" | at 4:00pm
echo "flake-update-check" | at 12:00am
echo "daily-flake-checks.sh" | at 12:01am # reset for next day..
