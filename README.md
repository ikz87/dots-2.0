# dots-2.0

## An updated, revised version of my dotfiles 

Dotfiles for this [post](https://www.reddit.com/r/unixporn/comments/wosl44/bspwm_decided_to_finally_learn_how_to_use_eww/).

I started using eww as a bar so I wrote everything from scratch and took the opportunity to be more organized. Remember to make scripts in `.bscripts` and `.config/eww/mybar/scripts` executable

Note: For the wallpaper dependant colorschemes use: `.bscripts/wallset <path to wallpaper>`

## Dependency list (may not be complete):
### AUR
just run this for this section (assuming you use yay):
```
yay -Sy acpi alsa-utils-git blueman brave-browser bspwm colorpicker dunst eww-git flameshot hsetroot kitty mantablockscreen network-manager-applet pavucontrol pa-applet-git picom-pijulius-git playerctl polkit-gnome polybar pulseaudio python3 rofi scrot spicetify-cli spotify sxhkd thunar wmctrl wpgtk xclip xdotool xprintidle --needed
```

### Other 
- [brightlight](https://github.com/multiplexd/brightlight) since for some reason xbacklight doesn't work on my machine. It's only used in `.bscripts/brightness.sh` so feel free to edit that script if you wanna use xbacklight instead.

### Fonts
- [Nova Mono](https://fonts.google.com/specimen/Nova+Mono?query=nova+mono)
- [Hack](https://github.com/source-foundry/Hack)
- [Font Awesome](https://fontawesome.com/download)

Please let me know if any packages are still missing
