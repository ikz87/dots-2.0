#!/bin/sh 

if [[ $2 == "Volume"* ]] 
then
    play -v 0.8 ~/Documents/Sounds/volume_notif.wav
elif [[ $2 == *"Screenshot"* ]] || [[ $2 == *"Flameshot"* ]]
then
    play -v 0.8 ~/Documents/Sounds/screenshot_notif.wav
fi;

