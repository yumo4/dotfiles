#!/usr/bin/env bash
HOSTNAME=$(hostname)
# if [ -e /sys/class/power_supply/BAT1 ]; then
if [[ "$HOSTNAME" == "framework" ]]; then
    # swww init &
    swww img ~/Projects/dotfiles/wallpaper/friendly-robot-ssd.jpg
elif [[ "$HOSTNAME" == "chimaera" ]]; then
    # swww-daemon &
    swww img --no-resize ~/Projects/dotfiles/wallpaper/julian-calle-falcon.jpg
else 
    swww img --no-resize ~/Projects/dotfiles/wallpaper/RMcQ-Deathstar-Construction.png
fi
