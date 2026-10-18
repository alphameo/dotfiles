#!/usr/bin/bash

ALL=" Configs (.config/)"
SCRIPTS=" Scripts (.scripts/)"

function open {
    local path="$1"
    coproc ($TERMINAL -d $path)
}

function run {
    INP="$@"
    if [[ $INP == $ALL ]]; then
        open $XDG_CONFIG_HOME
        exit 0
    elif [[ $INP == $SCRIPTS ]]; then
        open "~/.scripts/"
        exit 0
    else
        echo $ALL
        echo $SCRIPTS
        echo $ROFI
        echo $WAYBAR
        echo $HYPR
        echo $DUNST
        echo $SWAYNC
        echo $SWWW
        echo $FLAMESHOT
        echo $WLOGOUT
        exit 0
    fi
}

if [[ $1 == "open" ]]; then
    rofi -show "  " -modes "  :~/.config/rofi/scripts/dotfiles_manager.sh"
else
    run $@
fi
