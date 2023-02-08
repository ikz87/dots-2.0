#!/bin/sh

# Pauses notifications and locks the screen. 
# Notifications get resumed when screen is unlocked.

pkill -SIGUSR1 dunst # pause 
mantablockscreen -sc # requires https://github.com/reorr/mantablockscreen      
pkill -SIGUSR2 dunst # resume 
