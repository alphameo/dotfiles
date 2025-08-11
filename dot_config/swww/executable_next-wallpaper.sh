#!/usr/bin/bash

WALLPAPER_DIR="$HOME/Media/Pictures/Wallpapers/Dark-bg_anime"
INDEX_FILE="$HOME/.cache/swww_index"
TRANSITION="any"
DURATION=2
FPS=60

[[ -f "$INDEX_FILE" ]] || echo 0 >"$INDEX_FILE"

INDEX=$(<"$INDEX_FILE")
readarray -t wallpapers < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' \) | sort)
COUNT=${#wallpapers[@]}

if [[ $COUNT -eq 0 ]]; then
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

swww img "${wallpapers[$INDEX]}" \
    --transition-type "$TRANSITION" \
    --transition-fps "$FPS" \
    --transition-duration "$DURATION"

INDEX=$(((INDEX + 1) % COUNT))
echo "$INDEX" >"$INDEX_FILE"
