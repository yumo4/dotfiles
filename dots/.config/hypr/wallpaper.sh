#!/usr/bin/env bash
swww init &
if [ -e /sys/class/power_supply/BAT1 ]; then
    swww img ~/Projects/dotfiles/wallpaper/friendly-robot-ssd.jpg
else
    swww img ~/Projects/dotfiles/wallpaper/julian-calle-falcon.jpg
fi
