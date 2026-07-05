#!/usr/bin/env bash

timestamp=$(date +"%Y%m%d_%H%M%S")
conf="$HOME/.config/manual/icons/default.theme"
theme="/usr/share/icons/default/index.theme"
if [ -e "$theme" ]; then
    if [ -L "$theme" ]; then
        sudo rm "$theme"
    else
        sudo mv "$theme" "${theme}.${timestamp}.bak"
    fi
fi
sudo ln -rs "$conf" "$theme"
