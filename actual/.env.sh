#!/bin/env sh

# Path for Go
export PATH="$PATH:$(go env GOPATH)/bin"
# Path for pipx and other
export PATH="$PATH:$HOME/.local/bin"

# https://wiki.archlinux.org/title/XDG_Base_Directory#User_directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_MUSIC_DIR="$HOME/Media/Music"
export XDG_PICTURES_DIR="$HOME/Media/Pictures"
export XDG_VIDEOS_DIR="$HOME/Media/Videos"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_PUBLICSHARE_DIR="$HOME/Media/Public"

# https://wiki.archlinux.org/title/Environment_variables#Default_programs
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="zen-browser"
export PAGER="less"
export TERMINAL='kitty'

export LC_ALL="en_US.UTF-8"

export LF_CONFIG_HOME="$XDG_CONFIG_HOME"

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

export PRETTIERD_DEFAULT_CONFIG="$XDG_CONFIG_HOME/nvim/utils/prettierrc.json"

export ESLINT_DEFAULT_CONFIG="$XDG_CONFIG_HOME/nvim/utils/eslintrc.js"

export MARKDOWNLINT_DEFAULTCONFIG="$XDG_CONFIG_HOME/nvim/utils/markdown-lint-cli2.yaml"

export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GPG_TTY="$(tty)"

export JAVA_HOME="/usr/lib/jvm/java-25-openjdk"

export VENV_HOME="$HOME/.virtualenvs"
[ -d "$VENV_HOME" ] || mkdir "$VENV_HOME"

export TEXMFHOME="$XDG_DATA_HOME/texmf"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
export TEXMFCONFIG="$XDG_CONFIG_HOME/texlive/texmf-config"

export XCURSOR_PATH="${XCURSOR_PATH}:${XDG_DATA_HOME}/icons"

mkdir -p "$XDG_DATA_HOME/wineprefixes"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"

# Native file dialog for electron apps
export GTK_USE_PORTAL=1

export EZA_ICONS_AUTO=1

export RAINFROG_CONFIG="$XDG_CONFIG_HOME/rainfrog"

export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/config.toml"
