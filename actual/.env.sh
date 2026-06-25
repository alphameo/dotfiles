#!/bin/env sh

# https://wiki.archlinux.org/title/XDG_Base_Directory#User_directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# https://wiki.archlinux.org/title/Environment_variables#Default_programs
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="zen-browser"
export PAGER="less"
export TERMINAL='kitty'

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

# Native file dialog for electron apps
export GTK_USE_PORTAL=1

export EZA_ICONS_AUTO=1

export RAINFROG_CONFIG=~/.config/rainfrog

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

# # To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=31;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# For less theming
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
