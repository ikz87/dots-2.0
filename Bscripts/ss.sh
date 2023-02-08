#!/bin/sh

# Takes a screenshot of the whole screen.
# Screenshot is copied to clipboard and saved to
# ~/Pictures/Screenshots

mkdir -p ~/Pictures/Screenshots || true
date=`date +'%Y-%m-%d_%H:%M:%S'` && scrot ~/Pictures/Screenshots/$date.png -e 'xclip -selection clipboard -target image/png -i $f' && notify-send -u critical -t 3000 -i ~/Pictures/Screenshots/$date.png "Screenshot taken"
