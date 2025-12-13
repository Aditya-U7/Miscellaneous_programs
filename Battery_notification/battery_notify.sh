: 'Author: Aditya Upadhye

This is a bash program to notify you when your battery is below 30% and not charging. And when the battery is above 80% and charging.

This script requires the notify-send command to work. 

One can make this script run as a cron job using the following commands in terminal:

crontab -e  #For the current user.
*/after_number_of_minutes_you_want_this_script_to_run * * * *  absolute_path_to_bash absolute_path_to_this_file #Adding this line to cron file.

'


#! /bin/bash

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus; export DISPLAY=:0

battery_percent="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | cut -d ":" -f2 | xargs)"
battery_state="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | cut -d ":" -f2 | xargs)"
battery_percent="${battery_percent:0:-1}"

notify_title="Battery notification"
msg="Your battery is at $battery_percent%."

if [[ $battery_percent -le 30 && $battery_state == "discharging" ]]
then

        notify-send -u critical -i dialog-warning -a "$notify_title" "$msg Please connect the charger."

fi

if [[ $battery_percent -gt 80 && $battery_state == "charging" ]]
then

        notify-send -u critical -i dialog-warning -a "$notify_title" "$msg Please remove the charger."

fi
