#!/usr/bin/bash

DEFAULT_WALLPAPER=$HOME/Media/Pictures/Wallpapers/astronaut.jpg
PICKER=" Pick Wallpaper"
CYCLE=" Next Wallpaper"
RESET=" Reset Wallpaper"

function execute {
    coproc (eval "$1")
    exit 0
}

function run {
    INP="$@"

    if [[ $INP == $PICKER ]]; then
        execute "$HOME/.config/rofi/scripts/wallpaper_picker.sh"
    elif [[ $INP == $CYCLE ]]; then
        execute "$HOME/.config/swww/next-wallpaper.sh"
    elif [[ $INP == $RESET ]]; then
        swww img $DEFAULT_WALLPAPER
    else
        echo $PICKER
        echo $CYCLE
        echo $RESET
        exit 0
    fi
}

if [[ $1 == "open" ]]; then
    rofi -show " 󰸉 " -modes " 󰸉 :~/.config/rofi/scripts/wallpaper_manager.sh"
else
    run $@
fi
