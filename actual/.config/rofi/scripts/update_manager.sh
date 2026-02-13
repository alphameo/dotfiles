#! /bin/bash

ICON="󰚰 "
ALL=$ICON"All"
HYPR=$ICON"hypr"
YAZI=$ICON"yazi"
PACKAGES=$ICON"packages"
ZSH_ZINIT=$ICON"zsh zinit"

function run_in_term {
    coproc ($TERMINAL --hold zsh -c "$@")
    exit 0
}

yazi_upd="ya pkg upgrade"
hypr_upd="hyprpm update"
packages_upd="yay"
zinit_upd="source ~/.config/zsh/.zshrc && zinit self-update && zinit update"

function update_yazi {
    run_in_term "echo 'Updating yazi 󰇥 '; $yazi_upd"
}

function update_hypr {
    run_in_term "echo 'Updating hypr  '; $hypr_upd"
}

function update_packages {
    run_in_term "echo 'Updating packages '; $packages_upd"
}

function update_zinit {
    run_in_term "echo 'Updating zinit  '; $zinit_upd"
}

function update_all {
    run_in_term "echo 'Updating all package managers  ';$packages_upd; $hypr_upd; $zinit_upd; $yazi_upd"
}

function run {
    INP="$@"
    if [[ $INP == $HYPR ]]; then
        update_hypr
    elif [[ $INP == $YAZI ]]; then
        update_yazi
    elif [[ $INP == $PACKAGES ]]; then
        update_packages
    elif [[ $INP == $ZSH_ZINIT ]]; then
        update_zinit
    elif [[ $INP == $ALL ]]; then
        update_all
    else
        echo $ALL
        echo $PACKAGES
        echo $HYPR
        echo $YAZI
        echo $ZSH_ZINIT
        exit 0
    fi
}

if [[ $1 == "open" ]]; then
    rofi -show " 󰚰 " -modes " 󰚰 :~/.config/rofi/scripts/update_manager.sh"
else
    run $@
fi
