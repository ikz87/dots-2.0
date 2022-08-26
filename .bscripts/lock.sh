#!/bin/sh

pkill -SIGUSR1 dunst # pause 
mantablockscreen -sc # requires https://github.com/reorr/mantablockscreen      
pkill -SIGUSR2 dunst # resume 
