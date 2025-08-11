#!/usr/bin/bash

WALLPAPER_DIR="$HOME/Media/Pictures/Wallpapers"
TRANSITION="any"
DURATION=2
FPS=60

mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -type f | sort)

CHOSEN_INDEX=$(printf "%s\n" "${wallpapers[@]##*/}" | rofi -dmenu -format i -p "Wallpaper")
chosen_file="${wallpapers[$CHOSEN_INDEX]}"
if [[ -n "$chosen_file" ]]; then
    swww img $chosen_file \
        --transition-type "$TRANSITION" \
        --transition-fps "$FPS" \
        --transition-duration "$DURATION"

fi
