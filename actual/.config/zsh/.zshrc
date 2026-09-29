#!/bin/env zsh


source "$HOME/.config/sh/aliases.sh"

# https://github.com/ajeetdsouza/zoxide#Installation
eval "$(zoxide init zsh)"

# https://github.com/junegunn/fzf#setting-up-shell-integration
source <(fzf --zsh)
source "$HOME/.config/sh/fzf.sh"

# https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship
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
# https://github.com/olets/zsh-abbr
zinit depth"1" lucid light-mode for \
    olets/zsh-abbr \
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
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


###############
### OPTIONS ###
###############

# disbale Software Flow Control ctrl+s (to enable: stty -ixoff)
stty -ixon

# See https://zsh.sourceforge.io/Doc/Release/Options.html#History
HISTFILEDIR="$XDG_STATE_HOME/zsh"
[ -d "$HISTFILEDIR" ] || mkdir "$HISTFILEDIR"
HISTFILE="$XDG_STATE_HOME/zsh/history"

HISTSIZE=100000
SAVEHIST=$HISTSIZE

setopt APPEND_HISTORY
setopt SHARE_HISTORY # share history between instances
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS # don't save duplicate commands, old commands are deleted, new are written
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE # ignore commands starting with a space
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY

setopt EXTENDED_GLOB # ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation

setopt NOMATCH # print error if no matches

setopt NOTIFY # report status of background

setopt NO_BEEP

setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1


###############
### VI MODE ###
###############

bindkey -v # built-in vim mode (disable if zsh-vi-mode)
export KEYTIMEOUT=1

# Yank to the system clipboard
function vi-yank-xclip {
  zle vi-yank
  echo "$CUTBUFFER" | wl-copy
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip


################
### BINDKEYS ###
################

bindkey '^[[3~' delete-char            # del
bindkey '^[[107;6u' kill-whole-line    # ctrl+shift+k
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
