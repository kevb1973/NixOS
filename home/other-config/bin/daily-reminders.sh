#!/usr/bin/env bash
# Setup reminder notifications

echo "notify-snooze 'Take Iodine'" | at 1:00pm
echo "notify-snooze 'Time for Melatonin/Snack'" | at 11:30pm
echo "notify-snooze 'Time for Bed!'" | at 12:00am
echo "daily-reminders.sh" | at 12:01am # reset for next day..
