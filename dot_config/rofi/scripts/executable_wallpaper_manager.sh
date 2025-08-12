#!/usr/bin/bash

PICKER=" Pick Wallpaper (waypaper)"
RESET=" Reset Wallpaper"

function execute {
    coproc (eval "$1")
    exit 0
}

function run {
    INP="$@"

    if [[ $INP == $PICKER ]]; then
        execute "waypaper"
    elif [[ $INP == $RESET ]]; then
        swww img $DEFAULT_WALLPAPER
    else
        echo $PICKER
        echo $RESET
        exit 0
    fi
}

if [[ $1 == "open" ]]; then
    rofi -show " 󰸉 " -modes " 󰸉 :~/.config/rofi/scripts/wallpaper_manager.sh"
else
    run $@
fi
