#!/bin/bash

# Add custom directories to PATH
export PATH=$PATH:/home/kz87/.ricing    
export PATH=$PATH:/home/kz87/.bscripts    
export PATH=$PATH:/home/kz87/.osuthings    
export PATH=$PATH:/home/kz87/    
export PATH=$PATH:/home/kz87/.is    
export PATH=$PATH:/home/kz87/AppImages    
export PATH=$PATH:/home/kz87/.bin    
export PATH=$PATH:/home/kz87/.local/bin    
export PATH=$PATH:/home/kz87/.cargo/bin
export TERMINAL=/usr/bin/kitty

#Matlab fix
export _JAVA_AWT_WM_NONREPARENTING=1

# Colorscheme
source "${HOME}/.cache/wal/colors.sh"
export GTK_THEME=FlatColor

# Editor
export EDITOR='nvim'
export SUDO_EDITOR='nvim'

xset -b
xset b 0 0 0
setterm -blenghth 0
set bell-style none
amixer set 'Beep' 0% mute
~/.profile
export AWT_TOOLKIT=MToolkit


userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap


if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi


# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

  ## test for an existing bus daemon, just to be safe
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
      ## if not found, launch a new one
      eval `dbus-launch --sh-syntax`
      echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
fi

# Attempt to set XDG_SESSION_PATH if XDG_SESSION_ID is set
if [ -n "$XDG_SESSION_ID" ]; then
  export XDG_SESSION_PATH="/org/freedesktop/login1/session/$XDG_SESSION_ID"
  # You might also need to ensure the D-Bus session environment is aware of it
  # This is often helpful for services started within the X session
  dbus-update-activation-environment --systemd XDG_SESSION_ID XDG_SESSION_PATH > /dev/null 2>&1
else
  echo "Warning: XDG_SESSION_ID is not set. light-locker might not function correctly." >&2
fi

systemctl --user import-environment DISPLAY XAUTHORITY

interface=$GUI
[[ -z $interface ]] && interface=bspwm

case $interface in
    bspwm )
        eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)        
        export SSH_AUTH_SOCK
        exec bspwm
        ;;
    awesome )
        exec awesome
        ;;
    leftwm )
        exec leftwm
        ;;
    gnome )
        eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)    
        export SSH_AUTH_SOCK    
        exec gnome-session    
        ;;
    plasma )
        export DESKTOP_SESSION=plasma 
        exec startplasma-x11
        ;;
    dwm )
        ~/.config/dwm/autostart.sh&
        exec dwm
        ;;
    none ) 
        #Used for testing
        sxhkd -c ~/.config/bspwm/sxhkdrc
        ;;
    * )
        echo "$interface is not a valid interface"
        ;;
esac

