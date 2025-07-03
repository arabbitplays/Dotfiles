#!/usr/bin/env bash
command="$1"

# Define monitors (physical displays) and the number of virtual workspaces per monitor.
monitors=("DP-2" "HDMI-A-3" "HDMI-A-4")

# Define wallpapers array (one per virtual workspace).
wallpapers=(
    "$HOME/.config/hypr/Wallpaper1.jpg"
    "$HOME/.config/hypr/Wallpaper2.jpg"
    "$HOME/.config/hypr/Wallpaper3.jpg"
    "$HOME/.config/hypr/Wallpaper4.jpg"
)

###############################################################################
# Switch to the given virtual workspace on every monitor.
###############################################################################
switch_workspace_set() {
    local target_virtual="$1"

    for monitor in "${monitors[@]}"; do
        workspace=$(hyprctl monitors -j | jq -r --arg mon "$monitor" '.[] | select(.name==$mon) | .activeWorkspace.id')
        if [[ -n "$workspace" && "$workspace" != "null" ]]; then
            x=${workspace:0:1}

            new_ws="${x}${target_virtual}"
            echo "Switching $monitor to workspace: $new_ws"
            hyprctl dispatch workspace "$new_ws"
        else
            echo "Monitor $monitor not found or has no active workspace."
        fi
    done

    # After switching workspaces on all monitors, focus the middle monitor’s workspace (virtual workspace 2)
    middle_monitor="${monitors[1]}"  # Second monitor in the list
    workspace=$(hyprctl monitors -j | jq -r --arg mon "$middle_monitor" '.[] | select(.name==$mon) | .activeWorkspace.id')
    if [[ -n "$workspace" && "$workspace" != "null" ]]; then
        hyprctl dispatch workspace "$workspace"
    fi

    pkill -RTMIN+1 waybar
}


###############################################################################
# Send the active window to a new workspace on the same physical monitor,
# setting the virtual workspace (second digit) to the specified target.
###############################################################################
send_window() {
    local target_digit="$1"
    active_window=$(hyprctl activewindow -j | jq -r '.address')
    current_ws=$(hyprctl activeworkspace -j | jq -r '.id')
    
    # Use the first digit from the current workspace (physical monitor)
    # and the provided target_digit for the new virtual workspace.
    first_digit=${current_ws:0:1}
    target_ws="${first_digit}${target_digit}"
    
    echo "Sending active window $active_window from workspace $current_ws to workspace $target_ws"
    hyprctl dispatch movetoworkspacesilent "$target_ws"
}

###############################################################################
# Move the active window to the workspace on the monitor immediately to the left.
# This decrements the first digit (physical monitor) while keeping the virtual index.
###############################################################################
move_window_left() {
    active_window=$(hyprctl activewindow -j | jq -r '.address')
    current_ws=$(hyprctl activeworkspace -j | jq -r '.id')
    if [[ -z "$current_ws" || "$current_ws" == "null" ]]; then
        echo "No active workspace found."
        return
    fi
    first_digit=${current_ws:0:1}
    second_digit=${current_ws:1:1}
    physical_count=${#monitors[@]}
    
    new_first=$((first_digit - 1))
    if (( new_first < 1 )); then
        new_first=$physical_count
    fi
    target_ws="${new_first}${second_digit}"
    echo "Moving active window $active_window from workspace $current_ws to workspace $target_ws (mvleft)"
    
    hyprctl dispatch movetoworkspace "$target_ws,address:$active_window"
    hyprctl dispatch workspace "$target_ws"
}

###############################################################################
# Move the active window to the workspace on the monitor immediately to the right.
# This increments the first digit (physical monitor) while keeping the virtual index.
###############################################################################
move_window_right() {
    active_window=$(hyprctl activewindow -j | jq -r '.address')
    current_ws=$(hyprctl activeworkspace -j | jq -r '.id')
    if [[ -z "$current_ws" || "$current_ws" == "null" ]]; then
        echo "No active workspace found."
        return
    fi
    first_digit=${current_ws:0:1}
    second_digit=${current_ws:1:1}
    physical_count=${#monitors[@]}
    
    new_first=$((first_digit + 1))
    if (( new_first > physical_count )); then
        new_first=1
    fi
    target_ws="${new_first}${second_digit}"
    echo "Moving active window $active_window from workspace $current_ws to workspace $target_ws (mvright)"
    
    hyprctl dispatch movetoworkspace "$target_ws,address:$active_window"
    hyprctl dispatch workspace "$target_ws"
}

###############################################################################
# Return the current virtual workspace index (the second digit) from the active workspace.
# This value can be used by Waybar (or another status panel) to display the workspace index.
###############################################################################
get_workspace_index() {
    current_ws=$(hyprctl activeworkspace -j | jq -r '.id')
    if [[ -n "$current_ws" && "$current_ws" != "null" ]]; then
        # Extract the second digit as the virtual workspace index.
        index="${current_ws:1:1}"
        echo "$index"
    else
        echo "?"
    fi
}

test() {
    return "[
        {
            "text": "a",
            "class": "focused",
            "tooltip": "Workspace 1",
            "on-click": "hyprctl dispatch workspace 1"
        },
        {
            "text": "b",
            "class": "occupied",
            "tooltip": "Workspace 2",
            "on-click": "hyprctl dispatch workspace 2"
        },
        {
            "text": "c",
            "class": "empty",
            "tooltip": "Workspace 3",
            "on-click": "hyprctl dispatch workspace 3"
        },
        {
            "text": "d",
            "class": "empty",
            "tooltip": "Workspace 4",
            "on-click": "hyprctl dispatch workspace 4"
        }
    ]"
}

###############################################################################
# Dispatch command based on the provided argument.
###############################################################################
case "$command" in
    send)
        ws="$2"
        send_window $ws
        ;;
    switch)
        ws="$2"
        switch_workspace_set $ws
        ;;
    mvleft)
        move_window_left
        ;;
    mvright)
        move_window_right
        ;;
    getindex)
        get_workspace_index
        ;;
    *)
        echo "Usage: $0 {next|prev|send1|send2|send3|mvleft|mvright|getindex}"
        exit 1
        ;;
esac
