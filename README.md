# dots-2.0

## An updated, revised version of my dotfiles 

Dotfiles for this [post](https://www.reddit.com/r/unixporn/comments/wosl44/bspwm_decided_to_finally_learn_how_to_use_eww/).

I started using eww as a bar so I wrote everything from scratch and took the opportunity to be more organized. Remember to make scripts in `.bscripts` and `.config/eww/mybar/scripts` executable

Note: For the wallpaper dependant colorschemes use: `.bscripts/wallset <path to wallpaper>`

## Dependency list (may not be complete):
### AUR packages
just run this for this section (assuming you use yay):
```
yay -Sy acpi alsa-utils-git blueman brave-bin bspwm colorpicker dunst eww-git flameshot hsetroot imagemagick jq kitty mantablockscreen network-manager-applet pa-applet-git picom-pijulius-git playerctl polkit-gnome polybar pulseaudio python3 rofi scrot sox spicetify-cli spotify sxhkd thunar wmctrl wpgtk xclip xdotool xprintidle --needed
```
If you're not using arch, this is the dependency list, install in wathever way you want:
- acpi
- alsa-utils
- blueman
- brave
- bspwm
- colorpicker
- dunst
- eww
- flameshot
- hsetroot
- imagemagick
- jq
- kitty
- mantablockscreen
- network-manager-appler
- pa-applet
- pijulius' picom
- playerctl
- polkit-gnome
- polybar
- pulseaudio
- python3
- rofi
- scrot 
- sox 
- spicetify-cli
- spotify
- sxhkd
- thunar
- wmctrl
- wpgtk
- xclip
- xdotool
- xprintidle

### Other 
- [brightlight](https://github.com/multiplexd/brightlight) since for some reason xbacklight doesn't work on my machine. It's only used in `.bscripts/brightness.sh` so feel free to edit that script if you wanna use xbacklight instead.
- [pop_report](https://github.com/ikz87/pop_report) used in some scripts

### Optional
- plasma-integration [AUR package](https://aur.archlinux.org/packages/plasma-integration-git) and [chrome extension](https://chrome.google.com/webstore/detail/plasma-integration/cimiefiiaegbelhefglklhhakcgmhkai/related?hl=es) to better integrate media playing in brave with widgets (like having thumbnails of youtube videos show up in the left bar)


Please let me know if any packages are still missing

## Installing
just run install.sh:
``` 
chmod +x install.sh
./install.sh
```

TODO: Add a keybinds guide
