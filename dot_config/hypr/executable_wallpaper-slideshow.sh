#!/bin/bash

# Wallpaper slideshow script
# Changes wallpaper every 30 minutes from ~/wallpapers folder

WALLPAPER_DIR="$HOME/wallpapers"
INTERVAL=1800  # 30 minutes in seconds

# Initialize swww daemon
swww init &
sleep 2

# Function to get random wallpaper
get_random_wallpaper() {
    find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1
}

# Function to set wallpaper
set_wallpaper() {
    local wallpaper="$1"
    echo "Setting wallpaper: $wallpaper"
    swww img "$wallpaper" --transition-type wipe --transition-duration 2
}

# Check if wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Wallpaper directory $WALLPAPER_DIR does not exist"
    exit 1
fi

# Set initial wallpaper
initial_wallpaper=$(get_random_wallpaper)
if [ -n "$initial_wallpaper" ]; then
    set_wallpaper "$initial_wallpaper"
else
    echo "Error: No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Main loop - change wallpaper every 30 minutes
while true; do
    sleep "$INTERVAL"
    
    wallpaper=$(get_random_wallpaper)
    if [ -n "$wallpaper" ]; then
        set_wallpaper "$wallpaper"
    else
        echo "Warning: No wallpapers found, keeping current wallpaper"
    fi
done 