#!/usr/bin/env bash

config_dir=~/.config/hypr/config
laptop_dir=~/.config/hypr/laptop-config
desktop_dir=~/.config/hypr/desktop-config

case "$(hostname)" in
  nix-laptop)
    echo "Running on Laptop"

    for file in $laptop_dir/*; do
        filename=$(basename "$file")
        echo "Copy file: $filename"
        cp $laptop_dir/$filename $config_dir/$filename
    done

    ;;
  nix-desktop)
    echo "Running on Desktop"

    for file in $desktop_dir/*; do
        filename=$(basename "$file")
        echo "Copy file: $filename"
        cp $desktop_dir/$filename $config_dir/$filename
    done

    ;;
  *)
    echo "Unknown system: $(hostname)"
    ;;
esac