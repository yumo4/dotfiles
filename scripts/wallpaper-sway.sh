#!/usr/bin/env bash
HOSTNAME=$(hostname)
if [[ "$HOSTNAME" == "framework" ]]; then
	swaybg -o '*' -i ~/Projects/dotfiles/wallpaper/friendly-robot-ssd.jpg -m fill &
elif [[ "$HOSTNAME" == "chimaera" ]]; then
	swaybg -o '*' -i ~/Projects/dotfiles/wallpaper/julian-calle-falcon.jpg -m center &
elif [[ "$HOSTNAME" == "lusankya" ]]; then
	swaybg -o '*' -i ~/Projects/dotfiles/wallpaper/RMcQ-Tie-Pilot-MF.png &
else 
	# swaybg -o '*' -i ~/Projects/dotfiles/wallpaper/RMcQ-Deathstar-Construction.png -m &
	swaybg -o '*' -i ~/Projects/dotfiles/wallpaper/RMcQ-Tie-Pilot-MF.png &
fi
