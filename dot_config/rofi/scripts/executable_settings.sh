#!/usr/bin/bash

function open_config {
    local module="$1"
    if [[ ${#module} != 0 ]]; then
        coproc ($TERMINAL -d $XDG_CONFIG_HOME/$module $EDITOR)
        exit 0
    fi
}

function execute {
    coproc (eval "$1")
    exit 0
}

function launch_cli_app {
    coproc ($TERMINAL "$@")
    exit 0
}

function open_in_term {
    coproc($TERMINAL --hold "$@")
    exit 0
}

function run {
    INP="$@"
    ROFI=" rofi"
    WAYBAR=" waybar"
    HYPR=" hypr"
    DUNST="󰵚 dunst"
    NETWORK=" wifi"
    BLUETOOTH="󰂯 bluetooth"
    TOP="󰙭 monitor"
    SOUND=" sound"
    INFO=" info"
    GTK_UI="󰏘 GTK UI"
    KVANTUM="󰏘 GTK-QT link (kvantum)"
    QT5_UI="󰏘 QT5 UI (qt5ct)"
    QT6_UI="󰏘 QT6 UI (qt6ct)"
    DEFAULT_APPS="󰉺 Default Applications"

    if [[ $INP == $ROFI ]]; then
        open_config "rofi"
    elif [[ $INP == $WAYBAR ]]; then
        open_config "waybar"
    elif [[ $INP == $HYPR ]]; then
        open_config "hypr"
    elif [[ $INP == $DUNST ]]; then
        open_config "dunst"
    elif [[ $INP == $NETWORK ]]; then
        execute "networkmanager_dmenu"
    elif [[ $INP == $BLUETOOTH ]]; then
        execute "rofi-bluetooth"
    elif [[ $INP == $SOUND ]]; then
        execute "pavucontrol"
    elif [[ $INP == $TOP ]]; then
        launch_cli_app $SYSMONITOR
    elif [[ $INP == $INFO ]]; then
        open_in_term "fastfetch" "--config" "$HOME/.config/fastfetch/full.jsonc"
    elif [[ $INP == $GTK_UI ]]; then
        execute "nwg-look"
    elif [[ $INP == $KVANTUM ]]; then
        execute "kvantummanager"
    elif [[ $INP == $QT5_UI ]]; then
        execute "qt5ct"
    elif [[ $INP == $QT6_UI ]]; then
        execute "qt6ct"
    elif [[ $INP = $DEFAULT_APPS ]]; then
        execute "selectdefaultapplication"
    else
        echo $ROFI
        echo $WAYBAR
        echo $HYPR
        echo $DUNST
        echo $NETWORK
        echo $BLUETOOTH
        echo $TOP
        echo $SOUND
        echo $GTK_UI
        echo $KVANTUM
        echo $QT5_UI
        echo $QT6_UI
        echo $DEFAULT_APPS
        echo $INFO
        exit 0
    fi
}

if [[ $1 == "open" ]]; then
    rofi -show "   " -modes "   :~/.config/rofi/scripts/settings.sh"
else
    run $@
fi
