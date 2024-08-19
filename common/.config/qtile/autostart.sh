#!/bin/sh
feh --bg-scale /usr/share/endeavouros/backgrounds/endeavouros-wallpaper.png
picom & disown # --experimental-backends --vsync should prevent screen tearing on most setups if needed
nitrogen --restore &
redshift -O 4000
# Low battery notifier
~/.config/qtile/scripts/check_battery.sh & disown
# Set screen orientation
if [ -e /sys/class/power_supply/BAT0 ]; then
    # Battery is present, do nothing
else
    # No battery detected, execute xrandr command
    xrandr --output DisplayPort-2 --mode 1920x1080 --rate 144.00
fi
# xrandr --output HDMI-A-0 --rotate right
xrandr --output DisplayPort-2 --mode 1920x1080 --rate 144.00
# Start welcome
eos-welcome & disown

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & disown # start polkit agent from GNOME
# Autostart
obsidian &
