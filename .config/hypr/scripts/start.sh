#!/usr/bin/env bash

lxqt-policykit-agent &

clipse -listen

#hyprctl setcursor Dracula-cursors 24

nm-applet --indicator &

waybar &

dunst &

swww-daemon &
~/.config/hypr/scripts/swww-rotating.sh &

hyprctl dispatch workspace 11
hyprctl dispatch workspace 21
hyprctl dispatch workspace 31

# nix-index &