#!/usr/bin/env bash

# Set the path to the wallpapers directory
wallpapersDir="$HOME/.config/hypr/Wallpapers"
vertWallpapersDir="$HOME/.config/hypr/VerticalWallpapers"

# laptop
eDP_1_horizontal=1

# desktop
DP_2_horizontal=1
HDMI_A_3_horizontal=1
HDMI_A_4_horizontal=0

# Get a list of all image files in the wallpapers directory
wallpapers=("$wallpapersDir"/*)
vertWallpapers=("$vertWallpapersDir"/*)

show_rng_img_on_monitor() {
  local is_horizontal=$1
  local monitor_name=$2

   if [ ${#wallpapers[@]} -eq 0 ]; then
        # If the array is empty, refill it with the image files
        wallpapers=("$wallpapersDir"/*)
    fi

    if [ ${#vertWallpapers[@]} -eq 0 ]; then
        # If the array is empty, refill it with the image files
        vertWallpapers=("$vertWallpapersDir"/*)
    fi
  
  if [[ $is_horizontal -eq 1 ]]; then
    wallpaperIndex=$(( RANDOM % ${#wallpapers[@]} ))
    selectedWallpaper="${wallpapers[$wallpaperIndex]}"
    swww img "$selectedWallpaper" --transition-type outer --transition-pos top-right -o $monitor_name
  elif [[ $is_horizontal -eq 0 ]]; then
    wallpaperIndex=$(( RANDOM % ${#vertWallpapers[@]} ))
    selectedWallpaper="${vertWallpapers[$wallpaperIndex]}"
    swww img "$selectedWallpaper" --transition-type outer --transition-pos top-right -o $monitor_name
  else
    echo "Invalid boolean value. Please provide 1 for true or 0 for false."
  fi

  echo "Selection done for $monitor_name"
}

# Start an infinite loop
while true; do
    show_rng_img_on_monitor $eDP_1_horizontal eDP-1

    show_rng_img_on_monitor $DP_2_horizontal DP-2
    show_rng_img_on_monitor $HDMI_A_3_horizontal HDMI-A-3
    show_rng_img_on_monitor $HDMI_A_4_horizontal HDMI-A-4
    
    # Remove the selected wallpaper from the array
    #unset "wallpapers[$wallpaperIndex]"

    sleep 1h
done