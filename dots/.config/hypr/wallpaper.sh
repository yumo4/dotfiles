#!/usr/bin/env bash
if [ -e /sys/class/power_supply/BAT1 ]; then
    swww init &
    swww img ~/Projects/dotfiles/wallpaper/friendly-robot-ssd.jpg
else
    swww-daemon &
    swww img --no-resize ~/Projects/dotfiles/wallpaper/julian-calle-falcon.jpg
fi
