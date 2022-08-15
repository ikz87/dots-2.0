#!/usr/bin/env bash

date=`date +'%Y-%m-%d_%H:%M:%S'` && scrot ~/Pictures/Screenshots/$date.png -e 'xclip -selection clipboard -target image/png -i $f' && notify-send -u critical -t 3000 -i ~/Pictures/Screenshots/$date.png "Screenshot taken"
