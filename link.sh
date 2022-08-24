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
ln -s ./.bscripts ~/
ln -s ./colors.sh ~/
ln -s ./Documents/Sounds ~/Documents/
ln -s ./Pictures/Important ~/Pictures/
ln -s ./Pictures/Wallpapers ~/Pictures/

ln -s ./.config/bspwm ~/.config/
ln -s ./.config/dunst ~/.config/
ln -s ./.config/eww ~/.config/
ln -s ./.config/rofi ~/.config/
ln -s ./.config/wpg ~/.config/
ln -s ./.config/picom.conf ~/.config/

#permissions
chmod +x ./colors.sh

chmod +x ./.bscripts/*

chmod +x ./.config/bspwm/autostart
chmod +x ./.config/bspwm/hkpause
chmod +x ./.config/bspwm/bspwmrc
chmod +x ./.config/bspwm/quit.sh

chmod +x ./.config/eww/mybar/scripts/*

chmod +x ./.config/wpg/wp_init.sh


