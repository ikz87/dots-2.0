#!/bin/sh 

if [[ $2 == "Volume"* ]] 
then
    play -v 0.2 ~/.config/rice_assets/Sounds/volume_notif.wav > /dev/null&
elif [[ $2 == *"Screenshot"* ]] || [[ $2 == *"Flameshot"* ]]
then
    play -v 0.5 ~/.config/rice_assets/Sounds/screenshot_notif.wav > /dev/null&
fi;

