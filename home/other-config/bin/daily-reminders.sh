#!/usr/bin/env bash
# atrm $(atq | cut -f1)
# Setup reminder notifications

echo "notify-snooze --urgency=critical 'Take Iodine & Allergy Pill?'" | at 4:00pm
echo "notify-snooze --urgency=critical 'Time for Melatonin/Snack'" | at 11:30pm
echo "notify-snooze --urgency=critical 'Time for Bed!'" | at 12:00am
echo "daily-reminders.sh" | at 12:01am
# notify-send "Reminders have been set."
