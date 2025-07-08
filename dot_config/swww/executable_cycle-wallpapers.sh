#!/bin/bash

# Directory with your wallpapers
wallpaper_dir="$HOME/Media/Pictures/Wallpapers/Dark-bg_anime"
# File to store current index
index_file="$HOME/.cache/swww_index"

# Create file if not exists
[[ -f "$index_file" ]] || echo 0 >"$index_file"

# Read and update index
index=$(<"$index_file")
readarray -t wallpapers < <(find "$wallpaper_dir" -type f \( -iname '*.jpg' -o -iname '*.png' \) | sort)
count=${#wallpapers[@]}

if [[ $count -eq 0 ]]; then
    echo "No wallpapers found in $wallpaper_dir"
    exit 1
fi

# Set wallpaper
swww img "${wallpapers[$index]}" --transition-type any --transition-duration 2

# Increment index
index=$(((index + 1) % count))
echo "$index" >"$index_file"
