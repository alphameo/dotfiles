#!/usr/bin/bash

CONFIG_MNGR=" Config Manager"
NETWORK=" Network"
BLUETOOTH="󰂯 Bluetooth"
SOUND=" Sound"
DISPLAY_MNGR="󰍺 Display Manager"
UI_MNGR="󰉼 UI Manager"
LOCALE=" Locale Config (lxqt)"
DATE_TIME=" Date&Time (lxqt)"
USER=" User (lxqt)"
INPUT_DEVICES="󰍽 Input Devices (lxqt)"
DEFAULT_APPS="󰉺 Default Apps (lxqt)"
WALLPAPER_MNGR="󰸉 Wallpaper Manager"
UPDATE_MANAGER="󰚰 Update Manager"
POWER="󰐦 Power Menu"
SYS_MONITOR="󰙭 System Monitor (btop)"
INFO=" System Info (fastfetch)"

function execute {
    coproc (eval "$1")
    exit 0
}

function open_in_term {
    coproc ($TERMINAL --hold "$@")
    exit 0
}

function run {
    INP="$@"
    if [[ $INP == $CONFIG_MNGR ]]; then
        execute "$HOME/.config/rofi/scripts/config_manager.sh open"
    elif [[ $INP == $NETWORK ]]; then
        execute "$HOME/.scripts/open-network-manager.sh"
    elif [[ $INP == $BLUETOOTH ]]; then
        execute "$HOME/.scripts/open-bluetooth-manager.sh"
    elif [[ $INP == $SOUND ]]; then
        execute "$HOME/.scripts/open-sound-playback-manager.sh"
    elif [[ $INP == $SYS_MONITOR ]]; then
        execute "$HOME/.scripts/open-system-monitor.sh"
    elif [[ $INP == $DISPLAY_MNGR ]]; then
        execute "$HOME/.scripts/open-display-manager.sh"
    elif [[ $INP == $INFO ]]; then
        open_in_term "fastfetch" "--config" "$HOME/.config/fastfetch/full.jsonc"
    elif [[ $INP == $UI_MNGR ]]; then
        execute "$HOME/.config/rofi/scripts/ui_manager.sh open"
    elif [[ $INP == $UPDATE_MANAGER ]]; then
        execute "$HOME/.config/rofi/scripts/update_manager.sh open"
    elif [[ $INP = $DEFAULT_APPS ]]; then
        execute "lxqt-config-file-associations"
    elif [[ $INP = $LOCALE ]]; then
        execute "lxqt-config-locale"
    elif [[ $INP = $INPUT_DEVICES ]]; then
        execute "lxqt-config-input"
    elif [[ $INP = $DATE_TIME ]]; then
        execute "lxqt-admin-time"
    elif [[ $INP = $USER ]]; then
        execute "lxqt-admin-user"
    elif [[ $INP == $POWER ]]; then
        execute "rofi -show power-menu -modi power-menu:rofi-power-menu"
    elif [[ $INP == $WALLPAPER_MNGR ]]; then
        execute "$HOME/.config/rofi/scripts/wallpaper_manager.sh open"
    else
        echo $CONFIG_MNGR
        echo $NETWORK
        echo $BLUETOOTH
        echo $SOUND
        echo $UI_MNGR
        echo $DISPLAY_MNGR
        echo $UPDATE_MANAGER
        echo $WALLPAPER_MNGR
        echo $DEFAULT_APPS
        echo $LOCALE
        echo $DATE_TIME
        echo $INPUT_DEVICES
        echo $USER
        echo $POWER
        echo $SYS_MONITOR
        echo $INFO
        exit 0
    fi
}

if [[ $1 == "open" ]]; then
    rofi -show "  " -modes "  :~/.config/rofi/scripts/settings.sh"
else
    run $@
fi
