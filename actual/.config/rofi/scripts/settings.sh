#!/usr/bin/bash

DOTFILES_MNGR=" Dotfiles Manager"
NETWORK=" Network"
BLUETOOTH="󰂯 Bluetooth"
SOUND=" Sound"
DISPLAY_MNGR="󰍺 Display Manager"
UI_MNGR="󰉼 UI Manager"
CONFIG_LXQT=" Config (lxqt)"
WALLPAPER_MNGR="󰸉 Wallpaper Manager"
UPDATE_MANAGER="󰚰 Update Manager"
TASK_MNGR="󰙭 System Monitor"
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
    if [[ $INP == $DOTFILES_MNGR ]]; then
        execute "$HOME/.config/rofi/scripts/dotfiles_manager.sh open"
    elif [[ $INP == $NETWORK ]]; then
        execute "$HOME/.scripts/network-manager"
    elif [[ $INP == $BLUETOOTH ]]; then
        execute "$HOME/.scripts/bluetooth-manager"
    elif [[ $INP == $SOUND ]]; then
        execute "$HOME/.scripts/sound-manager"
    elif [[ $INP == $TASK_MNGR ]]; then
        execute "$HOME/.scripts/task-manager"
    elif [[ $INP == $DISPLAY_MNGR ]]; then
        execute "$HOME/.scripts/display-manager"
    elif [[ $INP == $INFO ]]; then
        open_in_term "fastfetch" "--config" "$HOME/.config/fastfetch/full.jsonc"
    elif [[ $INP == $UI_MNGR ]]; then
        execute "$HOME/.config/rofi/scripts/ui_manager.sh open"
    elif [[ $INP == $UPDATE_MANAGER ]]; then
        execute "$HOME/.config/rofi/scripts/update_manager.sh open"
    elif [[ $INP = $CONFIG_LXQT ]]; then
        execute "lxqt-config"
    elif [[ $INP == $WALLPAPER_MNGR ]]; then
        execute "$HOME/.config/rofi/scripts/wallpaper_manager.sh open"
    else
        echo $DOTFILES_MNGR
        echo $NETWORK
        echo $BLUETOOTH
        echo $SOUND
        echo $CONFIG_LXQT
        echo $UI_MNGR
        echo $DISPLAY_MNGR
        echo $WALLPAPER_MNGR
        echo $UPDATE_MANAGER
        echo $TASK_MNGR
        echo $INFO
        exit 0
    fi
}

if [[ $1 == "open" ]]; then
    rofi -show "  " -modes "  :~/.config/rofi/scripts/settings.sh"
else
    run $@
fi
