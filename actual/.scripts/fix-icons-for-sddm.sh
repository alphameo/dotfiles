#!/usr/bin/env bash

timestamp=$(date +"%Y%m%d_%H%M%S")

default_icons="/usr/share/icons/default"
if [ -z "$XCURSOR_THEME" ]; then
    echo "XCURSOR_THEME is not set"
else
    if [ -e "$default_icons" ]; then
        if [ -L "$default_icons" ]; then
            sudo rm "$default_icons"
        else
            sudo mv "$default_icons" "${default_icons}.${timestamp}.bak"
        fi
    fi
    target_theme="/usr/share/icons/$XCURSOR_THEME"
    if [ -d "$target_theme" ]; then
        sudo ln -rs "$target_theme" "$default_icons"
    else
        echo "'$target_theme' not found" >&2
    fi
fi
