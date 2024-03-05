#!/bin/sh

options=("default" "mirror")
selected_option=$(printf "%s\n" "${options[@]}" | rofi -dmenu -i -p "")

case "$selected_option" in
    "default")
        ~/git/dotfiles/scripts/defaultResolution.sh 
        ;;
    "mirror")
        ~/git/dotfiles/scripts/mirrorScreen.sh
        ;;
esac
setxkbmap -option caps:ctrl_modifier
nitrogen --restore &
