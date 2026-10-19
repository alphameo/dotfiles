#!/bin/bash

TODO: fix keymap sourcing
LAYOUT=$(hyprctl -j getoption general:layout | jq '.str' | sed 's/"//g')

case $LAYOUT in
"dwindle")
    hyprctl eval 'hl.config({general = {layout = "scrolling"}})' 
    # hyprctl eval 'equire("keymaps-scrolling")'
    # hyprctl source ~/.config/hypr/keymaps-scrolling.conf
    notify-send "Layout" "$LAYOUT -> scrolling"
    ;;
"scrolling")
    hyprctl eval 'hl.config({general = {layout = "dwindle"}})' 
    # hyprctl source ~/.config/hypr/keymaps-scrolling.conf
    # hyprctl keyword source ~/.config/hypr/keymaps-dwindle.lua
    notify-send "Layout" "$LAYOUT -> dwindle"
    ;;
*) ;;
esac
