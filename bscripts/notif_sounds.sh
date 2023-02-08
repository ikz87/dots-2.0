#!/bin/sh 

# Plays sounds when certain notifications pop up
# You can add options in the same manner. $2 is 
# the notification summary.

if [[ $2 == "Volume"* ]] 
then
    play -v 0.8 ~/Documents/Sounds/volume_notif.wav
elif [[ $2 == *"Screenshot"* ]] || [[ $2 == *"Flameshot"* ]]
then
    play -v 0.8 ~/Documents/Sounds/screenshot_notif.wav
fi;

