#!/bin/bash

LAYOUT=$(hyprctl -j getoption general:layout | jq '.str' | sed 's/"//g')

case $LAYOUT in
"dwindle")
    hyprctl keyword general:layout scrolling
    hyprctl keyword source ~/.config/hypr/keymaps-scrolling.conf
    notify-send "Layout" "$LAYOUT -> scrolling"
    ;;
"scrolling")
    hyprctl keyword general:layout dwindle
    hyprctl keyword source ~/.config/hypr/keymaps-dwindle.conf
    notify-send "Layout" "$LAYOUT -> dwindle"
    ;;
*) ;;
esac
