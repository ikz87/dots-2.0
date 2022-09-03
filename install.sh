#!/bin/sh

# Some directory names
old="${HOME}/.rice-old"
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

create_dir_tree()
{
    mkdir $1 || true
    mkdir $1/.bscripts || true
    mkdir $1/.config || true
    mkdir $1/Documents || true
    mkdir $1/Documents/Sounds || true
    mkdir $1/Pictures || true
    mkdir $1/Pictures/Important || true
    mkdir $1/Pictures/Important/icons || true
    mkdir $1/Pictures/Important/icons/other || true
    mkdir $1/Pictures/Wallpapers || true
    mkdir $1/.cache || true
    mkdir $1/.cache/wal || true
    mkdir $1/.local || true
    mkdir $1/.local/share || true
    mkdir $1/.local/share/fonts || true
}

echo -n "Preparing stuff... "
create_dir_tree ${HOME} 2> /dev/null
echo "done"

echo -n "Creating backup folders... "
rm -rf $old || true
create_dir_tree $old
echo "done"

echo -n "Backing up current configs... "
cp -r ~/.bscripts/* $old/.bscripts/ 2> /dev/null
cp -r ~/.config/bspwm $old/.config/ 2> /dev/null
cp -r ~/.config/eww $old/.config/ 2> /dev/null
cp -r ~/.config/dunst $old/.config/ 2> /dev/null
cp -r ~/.config/rofi $old/.config/ 2> /dev/null
cp -r ~/.config/pop_report $old/.config/ 2> /dev/null
cp -r ~/.config/wpg $old/.config/ 2> /dev/null
cp -r ~/.config/picom.conf $old/.config/ 2> /dev/null
cp -r ~/Documents/Sounds/* $old/Documents/Sounds/ 2> /dev/null
cp -r ~/Pictures/Important/* $old/Pictures/Important/ 2> /dev/null
cp -r ~/Pictures/Wallpapers/* $old/Pictures/Wallpapers/ 2> /dev/null
cp -r ~/.cache/wal/* $old/.cache/wal 2> /dev/null
cp -r ~/.local/share/fonts/* $old/.local/share/fonts/ 2> /dev/null
echo "done, you can find your backups at $old/"

echo -n "Applying rice... "
cp -r -f $script_dir/.bscripts/* ${HOME}/.bscripts/
cp -r -f $script_dir/.config/* ${HOME}/.config/
cp -r -f $script_dir/Documents/Sounds/* ${HOME}/Documents/Sounds/
cp -r -f $script_dir/Pictures/Important/* ${HOME}/Pictures/Important/
cp -r -f $script_dir/Pictures/Wallpapers/* ${HOME}/Pictures/Wallpapers/
cp -r -f $script_dir/.cache/wal/* ${HOME}/.cache/wal
cp -r -f $script_dir/.local/share/fonts/* ${HOME}/.local/share/fonts/
echo "done"

echo -n "Changing permissions... "
chmod +x ~/.bscripts/*
chmod +x ~/.config/bspwm/autostart
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/quit.sh
chmod +x ~/.config/eww/mybar/scripts/*
chmod +x ~/.config/wpg/wp_init.sh
chmod +x ~/.cache/wal/colors-tty.sh
echo "done"

echo "Install finished, Enjoy my rice c:"
