#!/usr/bin/bash

ALL=" Configs (.config/)"
ROFI=" Runner (rofi)"
WAYBAR=" Toolbar (waybar)"
HYPR=" Hypr (hypr)"
DUNST="󰵚 Notifier (dunst)"
SWWW="󰸉 Wallpaper (waypaper)"
FLAMESHOT=" Screenshots (flameshot)"

function open_config {
    local module="$1"
    local file="$2"
    if [[ ${#module} != 0 ]]; then
        coproc ($TERMINAL -d $XDG_CONFIG_HOME/$module $EDITOR $file)
        exit 0
    fi
}

function run {
    INP="$@"
    if [[ $INP == $ALL ]]; then
        coproc ($TERMINAL -d $XDG_CONFIG_HOME/)
        exit 0
    elif [[ $INP == $ROFI ]]; then
        open_config "rofi" "config.rasi"
    elif [[ $INP == $WAYBAR ]]; then
        open_config "waybar" "config.jsonc"
    elif [[ $INP == $HYPR ]]; then
        open_config "hypr" "hyprland.conf"
    elif [[ $INP == $DUNST ]]; then
        open_config "dunst" "dunstrc"
    elif [[ $INP == $SWWW ]]; then
        open_config "waypaper" "config.ini"
    elif [[ $INP == $FLAMESHOT ]]; then
        open_config "flameshot" "flameshot.ini"
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
