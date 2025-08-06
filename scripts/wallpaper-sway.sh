#!/usr/bin/env bash
HOSTNAME=$(hostname)
if [[ "$HOSTNAME" == "framework" ]]; then
	swaybg -o '*' -i ~/Projects/dotfiles/wallpaper/friendly-robot-ssd.jpg -m center &
elif [[ "$HOSTNAME" == "chimaera" ]]; then
	swaybg -o '*' -i ~/Projects/dotfiles/wallpaper/julian-calle-falcon.jpg -m center &
fi
