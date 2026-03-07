#!/usr/bin/bash

ALL=" Configs (.config/)"
SCRIPTS=" Scripts (.scripts/)"
ROFI=" Runner (rofi)"
WAYBAR=" Toolbar (waybar)"
HYPR=" Hypr (hypr)"
DUNST="󰵚 Notifier (dunst)"
SWAYNC="󰵚 Notifier (swaync)"
SWWW="󰸉 Wallpaper (waypaper)"
FLAMESHOT=" Screenshots (flameshot)"
WLOGOUT="󰐦 Logout menu (wlogout)"

function open {
    local path="$1"
    coproc ($TERMINAL -d $path)
}

function open_in_editor {
    local path="$1"
    local file="$2"
    if [[ ${#path} != 0 ]]; then
        coproc ($TERMINAL -d $path $EDITOR $file)
        exit 0
    fi
}

function open_config {
    local module="$1"
    local file="$2"
    open_in_editor $XDG_CONFIG_HOME/$module $file
}

function run {
    INP="$@"
    if [[ $INP == $ALL ]]; then
        open $XDG_CONFIG_HOME
        exit 0
    elif [[ $INP == $SCRIPTS ]]; then
        open "~/.scripts/"
        exit 0
    elif [[ $INP == $ROFI ]]; then
        open_config "rofi" "config.rasi"
    elif [[ $INP == $WAYBAR ]]; then
        open_config "waybar" "config.jsonc"
    elif [[ $INP == $HYPR ]]; then
        open_config "hypr" "hyprland.conf"
    elif [[ $INP == $DUNST ]]; then
        open_config "dunst" "dunstrc"
    elif [[ $INP == $SWAYNC ]]; then
        open_config "swaync" "config.json"
    elif [[ $INP == $SWWW ]]; then
        open_config "waypaper" "config.ini"
    elif [[ $INP == $FLAMESHOT ]]; then
        open_config "flameshot" "flameshot.ini"
    elif [[ $INP == $WLOGOUT ]]; then
        open_config "wlogout" "layout"
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
    rofi -show "  " -modes "  :~/.config/rofi/scripts/config_manager.sh"
else
    run $@
fi
