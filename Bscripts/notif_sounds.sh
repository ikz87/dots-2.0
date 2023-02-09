#!/bin/sh 

if [[ $2 == "Volume"* ]] 
then
    play -v 0.8 ~/.config/rice_assets/Sounds/volume_notif.wav
elif [[ $2 == *"Screenshot"* ]] || [[ $2 == *"Flameshot"* ]]
then
    play -v 0.8 ~/.config/rice_assets/Sounds/screenshot_notif.wav
fi;

