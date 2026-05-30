#!/usr/bin/env bash
# atrm $(atq | cut -f1)
# Setup reminder notifications

echo "notify-snooze --urgency=critical 'Take Iodine & Allergy Pill'" | at 1:00pm
echo "notify-snooze --urgency=critical 'Take 1tbsp Olive Oil'" | at 1:00pm
echo "notify-snooze --urgency=critical 'Take 1tbsp Olive Oil'" | at 7:00pm
echo "notify-snooze --urgency=critical 'Time for Melatonin/Snack'" | at 11:30pm
echo "notify-snooze --urgency=critical 'Time for Bed!'" | at 12:00am
echo "notify-snooze --urgency=critical 'Take 1tbsp Olive Oil'" | at 1:00am
echo "daily-reminders.sh" | at 1:01am # reset for next day..
