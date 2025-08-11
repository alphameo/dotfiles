#!/usr/bin/bash

CONFIG_MNGR=" Config Manager"
NETWORK=" Network (nmtui)"
BLUETOOTH="󰂯 Bluetooth (bluetui)"
SOUND=" Sound (pavucontrol)"
UI_MNGR="󰏘 UI Manager"
DEFAULT_APPS="󰉺 Default Applications"
WALLPAPER_MNGR="󰸉 Wallpaper Manager"
POWER="󰐦 Power Menu"
SYS_MONITOR="󰙭 System Monitor (btop)"
INFO=" System Info (fastfetch)"

function execute {
    coproc (eval "$1")
    exit 0
}

function launch_cli_app {
    coproc ($TERMINAL "$@")
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
        # execute "networkmanager_dmenu"
        launch_cli_app "nmtui"
    elif [[ $INP == $BLUETOOTH ]]; then
        # execute "rofi-bluetooth"
        launch_cli_app "bluetui"
    elif [[ $INP == $SOUND ]]; then
        execute "pavucontrol"
    elif [[ $INP == $SYS_MONITOR ]]; then
        launch_cli_app $SYSMONITOR
    elif [[ $INP == $INFO ]]; then
        open_in_term "fastfetch" "--config" "$HOME/.config/fastfetch/full.jsonc"
    elif [[ $INP == $UI_MNGR ]]; then
        execute "$HOME/.config/rofi/scripts/ui_manager.sh open"
    elif [[ $INP = $DEFAULT_APPS ]]; then
        execute "lxqt-config-file-associations"
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
        echo $KVANTUM
        echo $QT5_UI
        echo $QT6_UI
        echo $WALLPAPER_MNGR
        echo $DEFAULT_APPS
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
