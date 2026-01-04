#!/usr/bin/env bash

command="$1"

get_workspace_index() {
    current_ws=$(hyprctl activeworkspace -j | jq -r '.id')
    if [[ -n "$current_ws" && "$current_ws" != "null" ]]; then
        index="${current_ws:1:1}"
        echo "$index"
    else
        echo "?"
    fi
}

case "$command" in
    getindex)
        get_workspace_index
        ;;
    next|prev|send1|send2|send3|mvleft|mvright)
        # Implement your other commands here
        echo "Command '$command' not implemented yet"
        ;;
    *)
        echo "Usage: $0 {next|prev|send1|send2|send3|mvleft|mvright|getindex}"
        exit 1
        ;;
esac
