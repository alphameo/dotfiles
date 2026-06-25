#!/bin/env zsh


source "$HOME/.config/sh/aliases.sh"

eval "$(zoxide init zsh)"

source <(fzf --zsh)
source "$HOME/.config/sh/fzf.sh"

eval "$(starship init zsh)"


########################
### CUSTOM FUNCTIONS ###
########################

source "$HOME/.config/sh/functions.sh"

############################
### ZINIT plugin manager ###
############################
# See https://github.com/zdharma-continuum/zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# https://github.com/Aloxaf/fzf-tab
# https://github.com/zsh-users/zsh-syntax-highlighting (see EOF)
# https://github.com/zdharma-continuum/fast-syntax-highlighting
# https://github.com/zsh-users/zsh-completions
# https://github.com/marlonrichert/zsh-autocomplete
# https://github.com/zsh-users/zsh-autosuggestions
# https://github.com/zsh-users/zsh-history-substring-search
zinit depth"1" lucid light-mode for \
    Aloxaf/fzf-tab \
    zsh-users/zsh-syntax-highlighting \
    zsh-users/zsh-completions \
    zsh-users/zsh-autosuggestions \

# fzf-tab
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -a -1 --icons=always --color=always $realpath'


##################
### COMPLETION ###
##################

autoload -Uz compinit && compinit
# zinit ice wait'0' atinit'zicompinit; zicdreplay'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select


###############
### OPTIONS ###
###############

# disbale Software Flow Control ctrl+s (to enable: stty -ixoff)
stty -ixon

# See https://zsh.sourceforge.io/Doc/Release/Options.html#History
HISTFILEDIR="$XDG_STATE_HOME/zsh"
[ -d "$HISTFILEDIR" ] || mkdir "$HISTFILEDIR"
HISTFILE="$XDG_STATE_HOME/zsh/history"

HISTSIZE=10000
SAVEHIST=$HISTSIZE

setopt APPEND_HISTORY
setopt SHARE_HISTORY # share history between instances
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS # don't save duplicate commands, old commands are deleted, new are written
setopt HIST_IGNORE_SPACE # ignore commands starting with a space
setopt HIST_EXPIRE_DUPS_FIRST

# file matching
setopt EXTENDED_GLOB
setopt NOMATCH

# report status of background
setopt NOTIFY

setopt NOBEEP
setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1


###############
### VI MODE ###
###############

bindkey -v # built-in vim mode (disable if zsh-vi-mode)
export VI_MODE_SET_CURSOR=true
export KEYTIMEOUT=1

# Change cursor shape
# ANSI cursor escape codes:
# \e[0 q: Reset to the default cursor style.
# \e[1 q: Blinking block cursor.
# \e[2 q: Steady block cursor (non-blinking).
# \e[3 q: Blinking underline cursor.
# \e[4 q: Steady underline cursor (non-blinking).
# \e[5 q: Blinking bar cursor.
# \e[6 q: Steady bar cursor (non-blinking).# Change cursor shape for different vi modes.

# Register this functions as a ZLE (Zsh Line Editor) widget
function zle-keymap-select zle-line-init zle-line-finish
{
  case $KEYMAP in
      vicmd)      print -n '\033[1 q';; # block cursor
      viins|main) print -n '\033[5 q';; # line cursor
  esac
}
zle -N zle-line-init # runs once when a new ZLE session starts (e.g. when a prompt appears)
zle -N zle-line-finish
zle -N zle-keymap-select # called every time the keymap changes (insert <-> normal mode)

# Yank to the system clipboard
function vi-yank-xclip {
  zle vi-yank
  echo "$CUTBUFFER" | wl-copy
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# Press 'v' in normal mode to launch Vim with current line
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd m edit-command-line


################
### BINDKEYS ###
################

bindkey '^[[3;5~' kill-word            # ctrl+del
bindkey '^H' backward-kill-word        # ctrl+backspace
bindkey '^[[3~' delete-char            # del
bindkey '^[[107;6u' kill-whole-line    # ctrl+shift+k
bindkey '^[[H' beginning-of-line       # home
bindkey '^[[F' end-of-line             # end
bindkey '^[[1;5D' backward-word        # ctrl+left
bindkey '^[[1;5C' forward-word         # ctrl+right



### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
