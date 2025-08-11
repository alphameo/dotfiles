#!/usr/bin/bash

WALLPAPER_DIR="$HOME/Media/Pictures/Wallpapers"
PREVIEW_SIZE="40x25"
PREVIEW_POS="100,100"
TRANSITION="any"
DURATION=1
FPS=60

cleanup() {
    pkill swayimg 2>/dev/null
}
trap cleanup EXIT

show_preview() {
    local img="$1"
    pkill swayimg 2>/dev/null
    # swayimg --geometry "$PREVIEW_SIZE+$PREVIEW_POS" "$img" &
    swayimg --position="$PREVIEW_POS" --size="$PREVIEW_SIZE" "$img" &
}

mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -type f | sort)

index=$(printf "%s\n" "${wallpapers[@]##*/}" | rofi -dmenu -format i -p "Wallpaper" \
    -monitor -1 -lines 10 -hover-select -me-select-entry '' -me-accept-entry '' |
    while read -r idx; do
        if [[ -n "$idx" ]]; then
            show_preview "${wallpapers[$idx]}"
            echo "$idx" >/tmp/rofi_wallpaper_selection
        fi
    done)

if [[ -f /tmp/rofi_wallpaper_selection ]]; then
    sel_idx=$(cat /tmp/rofi_wallpaper_selection)
    selected_file="${wallpapers[$sel_idx]}"
    if [[ -n "$selected_file" ]]; then
        swww img "$selected_file" \
            --transition-type "$TRANSITION" \
            --transition-fps "$FPS" \
            --transition-duration "$DURATION"
    fi
    rm -f /tmp/rofi_wallpaper_selection
fi
