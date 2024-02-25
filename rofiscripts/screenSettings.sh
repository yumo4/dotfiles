#!/bin/sh

options=("default" "mirror")
selected_option=$(printf "%s\n" "${options[@]}" | rofi -dmenu -i -p "")

case "$selected_option" in
    "default")
        /home/max/scripts/defaultResolution.sh 
        ;;
    "mirror")
        /home/max/scripts/mirrorScreen.sh
        ;;
esac
setxkbmap -option caps:ctrl_modifier
nitrogen --restore &
