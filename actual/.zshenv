#!/bin/env sh

# source: https://wiki.archlinux.org/title/XDG_Base_Directory#User_directories 
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# source: https://wiki.archlinux.org/title/Zsh#Startup/Shutdown_files
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"


# src: https://wiki.archlinux.org/title/Environment_variables#Default_programs
export SHELL="/usr/bin/zsh"
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"
export PAGER="less"
export TERMINAL='kitty'
export LAUNCHER='rofi'
export FILEMANAGER='yazi'
export EXPLORER='thunar'
export SYSMONITOR='btop'


export LF_CONFIG_HOME="$XDG_CONFIG_HOME"

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

export PRETTIERD_DEFAULT_CONFIG="$HOME/.config/nvim/utils/prettierrc.json"

export ESLINT_DEFAULT_CONFIG="$HOME/.config/nvim/utils/eslintrc.js"

export MARKDOWNLINT_DEFAULTCONFIG="$HOME/.config/nvim/utils/markdown-lint-cli2.yaml"

export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GPG_TTY="$TTY"

export JAVA_HOME="/usr/lib/jvm/java-25-openjdk"

export VENV_HOME="$HOME/.virtualenvs"
[ -d "$VENV_HOME" ] || mkdir "$VENV_HOME"


export TEXMFHOME="$XDG_DATA_HOME/texmf"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
export TEXMFCONFIG="$XDG_CONFIG_HOME/texlive/texmf-config"

export XCURSOR_PATH="${XCURSOR_PATH}:${XDG_DATA_HOME}/icons"

mkdir -p "$XDG_DATA_HOME"/wineprefixes
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default

# oh-my-posh requirement
export PATH="$PATH":/home/a1pha/.local/bin

# Native file dialog for electron apps
export GTK_USE_PORTAL=1

export EZA_ICONS_AUTO=1

# For nmtui theming
export NEWT_COLORS='
root=#cdd6f4,#1e1e2e
window=#cdd6f4,#1e1e2e
border=#181825,#1e1e2e
shadow=#181825
title=#89b4fa,#1e1e2e
textbox=#cdd6f4,#1e1e2e
actlistbox=#1e1e2e,#89b4fa
button=#1e1e2e,#89b4fa
compactbutton=#89b4fa,#1e1e2e
checkbox=#cdd6f4,#1e1e2e
actcheckbox=#1e1e2e,#89b4fa
entry=#cdd6f4,#1e1e2e
label=#bac2de,#1e1e2e
listbox=#cdd6f4,#1e1e2e
actlistbox=#1e1e2e,#89b4fa
helpline=#f5c2e7,#1e1e2e
'
