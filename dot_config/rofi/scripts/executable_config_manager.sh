#!/usr/bin/bash

ALL=" Configs (.config/)"
ROFI=" Runner (rofi)"
WAYBAR=" Toolbar (waybar)"
HYPR=" Hypr (hypr)"
DUNST="󰵚 Notifier (dunst)"
SWWW="󰸉 Wallpaper (swww)"
FLAMESHOT=" Screenshots (flameshot)"

function open_config {
    local module="$1"
    if [[ ${#module} != 0 ]]; then
        coproc ($TERMINAL -d $XDG_CONFIG_HOME/$module $EDITOR)
        exit 0
    fi
}

function run {
    INP="$@"

    if [[ $INP == $ALL ]]; then
        coproc ($TERMINAL -d $XDG_CONFIG_HOME/ $EDITOR)
        exit 0
    elif [[ $INP == $ROFI ]]; then
        open_config "rofi"
    elif [[ $INP == $WAYBAR ]]; then
        open_config "waybar"
    elif [[ $INP == $HYPR ]]; then
        open_config "hypr"
    elif [[ $INP == $DUNST ]]; then
        open_config "dunst"
    elif [[ $INP == $SWWW ]]; then
        open_config "swww"
    elif [[ $INP == $FLAMESHOT ]]; then
        open_config "flameshot"
    else
        echo $ALL
        echo $ROFI
        echo $WAYBAR
        echo $HYPR
        echo $DUNST
        echo $SWWW
        echo $FLAMESHOT
        exit 0
    fi
}

if [[ $1 == "open" ]]; then
    rofi -show "  " -modes "  :~/.config/rofi/scripts/config_manager.sh"
else
    run $@
fi
