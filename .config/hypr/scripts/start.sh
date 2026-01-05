#!/usr/bin/env bash

~/.config/hypr/scripts/file-switcher.sh

lxqt-policykit-agent &

clipse -listen

#hyprctl setcursor Dracula-cursors 24

nm-applet --indicator &

waybar &

dunst &

swww-daemon &

systemctl --user restart desktop-manager.service

DesktopManagerCLI theme forest
DesktopManagerCLI workspace switch 1

# nix-index &
