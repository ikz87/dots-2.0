#!/bin/sh

# Some directory names
old="${HOME}/.rice-old"
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

create_home_dir_tree()
{
    mkdir "$1"/.bscripts || true
    mkdir "$1"/.config || true
    mkdir "$1"/.cache || true
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

create_backup()
{
    create_normal_dir_tree $old
    echo "done"

    echo -n "Backing up current configs... "
    cp -r ~/.config/rice_assets $old/Assets/ 2> /dev/null
    cp -r ~/.bscripts/ $old/Bscripts/ 2> /dev/null
    cp -r ~/.config/bspwm $old/Configs/ 2> /dev/null
    cp -r ~/.config/eww $old/Configs/ 2> /dev/null
    cp -r ~/.config/dunst $old/Configs/ 2> /dev/null
    cp -r ~/.config/kitty $old/Configs/ 2> /dev/null
    cp -r ~/.config/rofi $old/Configs/ 2> /dev/null
    cp -r ~/.config/pop_report $old/Configs/ 2> /dev/null
    cp -r ~/.config/wpg $old/Configs/ 2> /dev/null
    cp -r ~/.config/picom.conf $old/Configs/ 2> /dev/null
    cp -r ~/.config/rice_assets/ $old/Assets/ 2> /dev/null
    cp -r ~/.local/share/fonts/ "$script_dir"/Fonts 2> /dev/null
    cp -r ~/.local/share/fonts/ $old/Fonts 2> /dev/null
    cp -r ~/.cache/wal/ $old/Walcache/ 2> /dev/null
    echo "done, you can find your backups at $old/"
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
        rm -rf "$old"
        echo -n "Redoing directory tree... "
        create_backup
    else
        echo "Delete $old manually before installing"
        echo "Installation aborted"
        exit
    fi;
else
    create_backup
fi;


echo -n "Applying rice... "
for file in `ls "$script_dir"/Configs/`;
do 
    ln -s "$script_dir"/Configs/"$file" ${HOME}/.config/ 
done
ln -s -f "$script_dir"/Assets ${HOME}/.config/rice_assets
ln -s -f "$script_dir"/Bscripts ${HOME}/.bscripts
cp -r -f "$script_dir"/Walcache ${HOME}/.cache/wal
ln -s -f "$script_dir"/Fonts ${HOME}/.local/share/fonts
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
