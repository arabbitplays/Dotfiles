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
sleep 1 # sometimes this second is needed so that the following commands dont get lost, but i dont understand what the dependency is

DesktopManagerCLI theme forest
DesktopManagerCLI workspace switch 1

# nix-index &
