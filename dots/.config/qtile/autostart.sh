#!/bin/sh
# Autostart
nitrogen --restore &
redshift -O 4000
obsidian &
# laptop / desktop autostart 
if [ -e /sys/class/power_supply/BAT1 ]; then
    # setxkbmap -option caps:ctrl_modifier
else
    # xrandr --output DisplayPort-2 --mode 1920x1080 --rate 144.00
    xrandr --output DisplayPort-2 --mode 1920x1080 --rate 143.98
fi

# xrandr --output HDMI-A-0 --rotate right
# xrandr --output DisplayPort-2 --mode 1920x1080 --rate 144.00
