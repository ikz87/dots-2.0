# dots-2.0

## An updated, revised version of my dotfiles 

Dotfiles for this [post](https://www.reddit.com/r/unixporn/comments/wosl44/bspwm_decided_to_finally_learn_how_to_use_eww/).

<p align="center">
  <img src="https://user-images.githubusercontent.com/98569017/188286072-d91b2027-7fc7-4a65-a45b-223d378afca0.png" width=30% height=30%>
  <img src="https://user-images.githubusercontent.com/98569017/188286092-9131b97a-aa50-4fe8-9179-3cda440c1abc.png" width=30% height=30%>
  <img src="https://user-images.githubusercontent.com/98569017/188286460-d450f8b0-545d-4612-9a8b-99dafe223ed5.png" width=30% height=30%>
</p>

<p align="center">
<img src="https://user-images.githubusercontent.com/98569017/188286589-7b0fea41-b8f9-42f8-b376-175a13ef8fd7.gif" 
</p>

I started using eww as a bar so I wrote everything from scratch and took the opportunity to be more organized.

For the wallpaper dependant colorschemes use: `.bscripts/wallset <path to wallpaper>`.

The profile picture shown in the lockscreen can be changed by putting the desired image in `~/.face`.

Please note that this rice was made for a single 1080p monitor setup, If you have anything different than that you'll have to tweak some things on your own.

~~The picom fork used for animations might be a little unstable~~ (shouldn't be anymore). For any graphical glitches you may be having, toggle it off and on again with `super+p`.

## Dependency list:
### AUR packages
Just run this for this section (assuming you use yay):
```
yay -Sy acpi alsa-utils-git blueman brave-bin bspwm colorpicker dunst eww-git flameshot hsetroot imagemagick jq kitty mantablockscreen network-manager-applet pa-applet-git playerctl polkit-gnome polybar pulseaudio python3 rofi scrot sox spicetify-cli spotify sxhkd thunar wmctrl wpgtk-git xclip xdotool xprintidle xwinfo-git --needed
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
- network-manager-applet
- pa-applet
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
- xwinfo

### Other 
- [brightlight](https://github.com/multiplexd/brightlight) since for some reason xbacklight doesn't work on my machine. It's only used in `.bscripts/brightness.sh` so feel free to edit that script if you wanna use xbacklight instead.
- [FT-Labs-picom](https://github.com/FT-Labs/picom) more stable fork of picom with better looking animations (no shadows for now, as they are glitchy at the moment).
- [pop_report](https://github.com/ikz87/pop_report) used in some scripts.

### Optional
- plasma-integration [AUR package](https://aur.archlinux.org/packages/plasma-integration-git) and [chrome extension](https://chrome.google.com/webstore/detail/plasma-integration/cimiefiiaegbelhefglklhhakcgmhkai/related?hl=es) to better integrate media playing in brave with widgets (like having thumbnails of youtube videos show up in the left bar).


Please let me know if any packages are still missing.

## Installing
Just run install.sh:
``` 
chmod +x install.sh
./install.sh
```

## Keybinds
| Key combo               | Action |
|   ---                   |  ---   |
| Super+Return            | Pause/Resume sxhkd |
| Control+Alt+W           | Open browser (brave is default) |
| Control+Alt+T           | Open terminal (kitty is default) |
| Control+Alt+F           | Open file manager (thunar is default | 
| Super+P                 | Toggle picom |
| Super+Shift+E           | Open rofi in drun mode (app launcher) |
| Alt+Tab                 | Windows-like window switcher using rofi |
| Super+Shift+Q           | Show logout menu |
| Print                   | Take a screenshot (Saved to ~/Pictures/Screenshots and clipboard) |
| Super+Print             | Same as above, but with 3 second delay | 
| Control+Alt+C           | Color picker, copies color at cursor to clipboard in HEX on click |
| Super+O                 | Locks the PC (PC suspends after 5 seconds of inactivity while locked) |
| Super+Space             | Change keyboard layout (Cycles between us spanish and us english layouts) |
| Super+C                 | Close focused window | 
| Alt+F4                  | Force closing focused window (for frozen programs) | 
| Control+Period          | Move focused window to next workspace |
| Contro+Comma            | Move focused window to previous workspace |
| Control+Alt+Period      | Go to next workspace | 
| Control+Alt+Comma       | Go to previous workspace | 
| Super+{1,2,3,4,5}       | Jump to workspaces 1 through 5 |
| Alt+Period              | Raise the volume by 5% (Warning: No volume cap set, you really shouldn't go above 150%) | 
| Alt+Comma               | Lower the volume by 5% |
| Alt+M                   | Toggle mute volume | 
| Alt+Shift+Period        | Raise brightness by 5% | 
| Alt+Shift+Comma         | Lower brightness by 5% | 
| Control+Alt+E           | Toggle status bar |
| Super+M                 | Toggle eww media control window | 
| Super+S                 | Toggle monocle BSPWM layout | 
| Control+Alt+Space       | Toggle floating mode on focused window | 
| Super+Shift+{K,J,H,L}   | Move window |
| Super+{K,J,H,L}         | Select window |
| Super+Alt+{K,J,H,L}     | Grow focused window in desired direction | 
| Control+Shift+{K,J,H,L} | Shrink focused window in desired direction | 
| Super+{D,A}             | Rotate BSPWM tree at node (clockwise/counterclockwise) |
| Alt+{D,A}               | Rotate windows at node (clockwise/counterclockwise) |
| Super+E                 | Equalize window sizes |
| Super+F                 | Toggle fullscreen |
| Super+KP_Add            | Raise window gaps by 5px |
| Super+KP_Subtract       | Lower window gaps by 5px |
| Control+Alt+{K,J,H,L}   | Preselect direction for next window | 
| Control+Alt+A           | Cycle through window layers (above, normal or below) | 

These are all the kibinds set in the `~/.config/bspwm/sxhkdrc` file, however, if you are gonna use this as your daily driver, I highly encourage you to read that file in its entirity at least once, so you know what's going on behind the scenes.
