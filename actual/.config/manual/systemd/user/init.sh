#!/usr/bin/env bash

timestamp=$(date +"%Y%m%d_%H%M%S")

config="$HOME/.config/manual/systemd/user/battery-notify"
etc="/etc/systemd/user/battery-notify"
etc_svc="$etc.service"
if [ -e "$etc_svc" ]; then
    if [ -L "$etc_svc" ]; then
        sudo rm "$etc_svc"
    else
        sudo mv "$etc_svc" "${etc_svc}.${timestamp}.bak"
    fi
fi
sudo ln -rs "$config.service" "$etc_svc"

etc_tmr="$etc.timer"
if [ -e "$etc_tmr" ]; then
    if [ -L "$etc_tmr" ]; then
        sudo rm "$etc_tmr"
    else
        sudo mv "$etc_tmr" "${etc_tmr}.${timestamp}.bak"
    fi
fi
sudo ln -rs "$config.timer" "$etc_tmr"

systemctl --user daemon-reload

systemctl --user enable --now battery-notify.service
systemctl --user enable --now battery-notify.timer
