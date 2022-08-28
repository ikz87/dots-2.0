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
cp -r ~/.bscripts/* $old/.bscripts/
cp -r ~/.config/* $old/.config/
cp -r ~/Documents/Sounds/* $old/Documents/Sounds/
cp -r ~/Pictures/Important/* $old/Pictures/Important/
cp -r ~/Pictures/Wallpapers/* $old/Pictures/Wallpapers/
cp -r ~/Pictures/.cache/wal/* $old/.cache/wal
cp -r ~/.local/share/fonts/* $old/.local/share/fonts/
echo "done"

echo -n "Applying rice... "
mv -f $script_dir/.bscripts/* ${HOME}/.bscripts/
mv -f $script_dir/.config/* ${HOME}/.config/
mv -f $script_dir/Documents/Sounds/* ${HOME}/Documents/Sounds/
mv -f $script_dir/Pictures/Important/* ${HOME}/Pictures/Important/
mv -f $script_dir/Pictures/Wallpapers/* ${HOME}/Pictures/Wallpapers/
mv -f $script_dir/Pictures/.cache/wal/* ${HOME}/.cache/wal
mv -f $script_dir/.local/share/fonts/* ${HOME}/.local/share/fonts/
echo "done"

echo -n "Changing permissions... "
chmod +x ~/.bscripts/*
chmod +x ~/.config/bspwm/autostart
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/quit.sh
chmod +x ~/.config/eww/mybar/scripts/*
chmod +x ~/.config/wpg/wp_init.sh/
chmod +x ~/.cache/wal/colors-tty.sh
echo "done"

echo "Install finished, Enjoy my rice c:"
