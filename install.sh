#!/bin/sh

# Some directory names
old="${HOME}/.rice-old"
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

create_home_dir_tree()
{
    mkdir "$1"/.bscripts || true
    mkdir "$1"/.config || true
    mkdir -p "$1"/.local/share/fonts || true
}

create_normal_dir_tree()
{
    mkdir -p "$1"/Assets || true
    mkdir -p "$1"/Bscripts || true
    mkdir -p "$1"/Configs || true
    mkdir -p "$1"/Fonts || true
    mkdir -p "$1"/Walcache || true
}

echo -n "Preparing stuff... "
create_home_dir_tree ${HOME} 2> /dev/null
echo "done"

echo -n "Creating backup directory tree... "
if [[ -d "$old" ]] 
then
    echo ""
    echo "WARNING: There seems to already be a backup at '$old'"
    echo "Do you wanna overwrite it (y/N)?"
    read input
    if [[ "$input" == "y" ]] || [[ "$input" == "Y" ]] 
    then
        rm -rf $old
        echo -n "Redoing directory tree... "
    else
        echo "Aborting rice install"
    fi;

create_dir_tree $old
echo "done"

echo -n "Backing up current configs... "
mv ~/.bscripts/* $old/Bscripts/ 2> /dev/null
mv ~/.config/bspwm $old/Configs/ 2> /dev/null
mv ~/.config/eww $old/Configs/ 2> /dev/null
mv ~/.config/dunst $old/Configs/ 2> /dev/null
mv ~/.config/rofi $old/Configs/ 2> /dev/null
mv ~/.config/pop_report $old/Configs/ 2> /dev/null
mv ~/.config/wpg $old/Configs/ 2> /dev/null
mv ~/.config/picom.conf $old/Configs/ 2> /dev/null
mv ~/.config/rice_assets/* $old/Assets/ 2> /dev/null
cp -r ~/.local/share/fonts/* "$script_dir"/Fonts 2> /dev/null
mv ~/.local/share/fonts/* $old/Fonts 2> /dev/null
mv ~/.cache/wal/* $old/Walcache/ 2> /dev/null
echo "done, you can find your backups at $old/"

echo -n "Applying rice... "
for file in `ls "$script_dir"/Configs/`;
do 
    ln -s "$script_dir"/Configs/"$file" ${HOME}/.config/"$file"
done
ln -s "$script_dir"/Assets ${HOME}/.config/rice_assets
ln -s "$script_dir"/Bscripts/* ${HOME}/.bscripts/
cp "$script_dir"/Walcache ${HOME}/.cache/wal
ln -s "$script_dir"/Fonts ${HOME}/.local/share/fonts/
echo "done"

echo -n "Changing script permissions... "
chmod +x ~/.bscripts/*
chmod +x ~/.config/bspwm/autostart
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/quit.sh
chmod +x ~/.config/eww/mybar/scripts/*
chmod +x ~/.config/wpg/wp_init.sh
chmod +x ~/.cache/wal/colors-tty.sh
echo "done"

echo "Running wpg-install.sh -g for the gtk colorscheme"
chmod +x "$script_dir"/.bscripts/wpg-install.sh 
"$script_dir"/.bscripts/wpg-install.sh -g 

echo "Install finished, Enjoy my rice c:"
