#!/usr/bin/env bash

timestamp=$(date +"%Y%m%d_%H%M%S")

conf="$HOME/.config/manual/nix/nix.conf"
etc_conf="/etc/nix/nix.conf"
if [ -e "$etc_conf" ]; then
    if [ -L "$etc_conf" ]; then
        sudo rm "$etc_conf"
    else
        sudo mv "$etc_conf" "${etc_conf}.${timestamp}.bak"
    fi
fi
sudo ln -rs "$conf" "$etc_conf"
