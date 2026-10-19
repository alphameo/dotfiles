#!/bin/env sh

source "$HOME/.env.sh"

export SHELL="/usr/bin/zsh"

# https://wiki.archlinux.org/title/Zsh#Startup/Shutdown_files
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# zsh-abbr: set envvar before plugin load
export ABBR_USER_ABBREVIATIONS_FILE="$XDG_CONFIG_HOME/zsh/abbr.zsh"
