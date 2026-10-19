#!/usr/bin/bash

ICON="󰉼 "
COMMON_UI=$ICON"COMMON UI (lxqt)"
GTK_UI=$ICON"GTK UI (nwg-look)"
KVANTUM=$ICON"GTK-QT link (kvantum)"
QT5_UI=$ICON"QT5 UI (qt5ct)"
QT6_UI=$ICON"QT6 UI (qt6ct)"

function execute {
    coproc (eval "$1")
    exit 0
}

function run {
    INP="$@"
    if [[ $INP == $COMMON_UI ]]; then
        execute "lxqt-config-appearance"
    elif [[ $INP == $GTK_UI ]]; then
        execute "nwg-look"
    elif [[ $INP == $KVANTUM ]]; then
        execute "kvantummanager"
    elif [[ $INP == $QT5_UI ]]; then
        execute "qt5ct"
    elif [[ $INP == $QT6_UI ]]; then
        execute "qt6ct"
    else
        echo $COMMON_UI
        echo $GTK_UI
        echo $KVANTUM
        echo $QT5_UI
        echo $QT6_UI
        exit 0
    fi
}

if [[ $1 == "open" ]]; then
    rofi -show " 󰉼 " -modes " 󰉼 :~/.config/rofi/scripts/ui_manager.sh"
else
    run $@
fi
