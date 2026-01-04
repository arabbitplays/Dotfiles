#!/usr/bin/env bash

~/.config/hypr/scripts/file-switcher.sh

lxqt-policykit-agent &

clipse -listen

#hyprctl setcursor Dracula-cursors 24

nm-applet --indicator &

waybar &

dunst &

swww-daemon &
DesktopManagerCLI theme forest

hyprctl dispatch workspace 11
hyprctl dispatch workspace 21
hyprctl dispatch workspace 31

# nix-index &
