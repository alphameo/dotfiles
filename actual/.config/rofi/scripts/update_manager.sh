#! /bin/bash

ICON="󰚰 "
ALL=$ICON"All"
HYPR=$ICON"hypr"
YAZI=$ICON"yazi"
PACKAGES=$ICON"packages"

function run_in_term {
    coproc ($TERMINAL --hold "$@")
    exit 0
}

function update_yazi {
    run_in_term "ya" "pkg" "upgrade"
}

function update_hypr {
    run_in_term "hyprpm" "update"
}

function update_packages {
    run_in_term "yay"
}


function update_all {
    update_packages
    update_yazi
    update_hypr
}

function run {
    INP="$@"
    if [[ $INP == $HYPR ]]; then
        update_hypr
    elif [[ $INP == $YAZI ]]; then
        update_yazi
    elif [[ $INP == $PACKAGES ]]; then
        update_packages
    elif [[ $INP == $ALL ]]; then
        update_all
    else
        echo $ALL
        echo $PACKAGES
        echo $HYPR
        echo $YAZI
        exit 0
    fi
}

if [[ $1 == "open" ]]; then
    rofi -show " 󰚰 " -modes " 󰚰 :~/.config/rofi/scripts/update_manager.sh"
else
    run $@
fi
