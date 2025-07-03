#!/usr/bin/env bash

# Save current clipboard
OLD_CLIP=$(wl-paste)

# Launch Clipse and wait for it to exit
kitty --class clipse -e clipse

# Give it a short moment to update clipboard
sleep 0.3

# Get the new clipboard content
NEW_CLIP=$(wl-paste)

# Compare and type if changed
if [[ "$NEW_CLIP" != "$OLD_CLIP" && -n "$NEW_CLIP" ]]; then
    wtype "$NEW_CLIP"
fi
