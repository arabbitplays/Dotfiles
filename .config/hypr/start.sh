#!/usr/bin/env bash

lxqt-policykit-agent &

clipse -listen

#hyprctl setcursor Dracula-cursors 24

nm-applet --indicator &

waybar &

dunst &

swww-daemon &
~/.config/hypr/swww-rotating.sh &