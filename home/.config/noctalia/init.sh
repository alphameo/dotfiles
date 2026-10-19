#!/usr/bin/env bash

timestamp=$(date +"%Y%m%d_%H%M%S")

conf="$HOME/.config/noctalia/settings.toml"
gui_conf="~/.local/state/noctalia/settings.toml"
if [ -e "$gui_conf" ]; then
    if [ -L "$gui_conf" ]; then
        sudo rm "$gui_conf"
    else
        sudo mv "$gui_conf" "${gui_conf}.${timestamp}.bak"
    fi
fi
sudo ln -rs "$conf" "$gui_conf"
