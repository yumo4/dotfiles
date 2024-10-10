#!/bin/sh
# picom & disown # --experimental-backends --vsync should prevent screen tearing on most setups if needed
nitrogen --restore &
redshift -O 4000
# laptop / desktop autostart 
if [ -e /sys/class/power_supply/BAT1 ]; then
    setxkbmap -option caps:ctrl_modifier
else
    xrandr --output DisplayPort-2 --mode 1920x1080 --rate 144.00
fi

# xrandr --output HDMI-A-0 --rotate right
# xrandr --output DisplayPort-2 --mode 1920x1080 --rate 144.00

# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & disown # start polkit agent from GNOME
# Autostart
obsidian &
