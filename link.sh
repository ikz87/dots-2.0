#!/bin/sh

# clean 
rm -f ~/colors.sh
rm -rf ~/.bscripts
rm -rf ~/Documents/Sounds
rm -rf ~/Pictures/Important
rm -rf ~/Pictures/Wallpapers

rm -rf ~/.config/bspwm
rm -rf ~/.config/dunst
rm -rf ~/.config/eww
rm -rf ~/.config/rofi
rm -rf ~/.config/wpg
rm -f ~/.config/picom.conf

# prep
mkdir -p ~/.config > /dev/null

# link
ln -s ~/Dots/.bscripts ~/
ln -s ~/Dots/colors.sh ~/
ln -s ~/Dots/Documents/Sounds/ ~/Documents/
ln -s ~/Dots/Pictures/Important/ ~/Pictures/
ln -s ~/Dots/Pictures/Wallpapers/ ~/Pictures/

ln -s ~/Dots/.config/bspwm ~/.config/
ln -s ~/Dots/.config/dunst ~/.config/
ln -s ~/Dots/.config/eww ~/.config/
ln -s ~/Dots/.config/rofi ~/.config/
ln -s ~/Dots/.config/wpg ~/.config/
ln -s ~/Dots/.config/picom.conf ~/.config/

#permissions
chmod +x ~/Dots/colors.sh

chmod +x ~/Dots/.bscripts/*

chmod +x ~/Dots/.config/bspwm/autostart
chmod +x ~/Dots/.config/bspwm/hkpause
chmod +x ~/Dots/.config/bspwm/bspwmrc
chmod +x ~/Dots/.config/bspwm/quit.sh

chmod +x ~/Dots/.config/eww/mybar/scripts/*

chmod +x ~/Dots/.config/wpg/wp_init.sh


