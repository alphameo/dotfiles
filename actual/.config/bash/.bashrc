#!/bin/env bash

iatest=$(expr index "$-" i) # is interactive shell

source "$HOME/.config/sh/aliases.sh"

eval "$(zoxide init bash)"

eval "$(fzf --bash)"
source "$HOME/.config/sh/fzf.sh"

eval "$(starship init bash)"

source "$HOME/.config/sh/functions.sh"

######################
#### BLE.SH plugin ###
######################
BASH_BLE_DIR="${XDG_DATA_HOME:-${HOME}/.local/share}/blesh"
if [ ! -d "$BASH_BLE_DIR" ]; then
    echo "Installing ble.sh"
    tmp_dir=/tmp/ble.sh
    git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git $tmp_dir
    make -C $tmp_dir install PREFIX=~/.local
    rm -rf $tmp_dir
fi
if [[ $iatest -gt 0 ]]; then source -- ~/.local/share/blesh/ble.sh; fi


##################
### COMPLETION ###
##################
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

if [[ $iatest -gt 0 ]]; then bind "set completion-ignore-case on"; fi
if [[ $iatest -gt 0 ]]; then bind "set show-all-if-ambiguous on"; fi
bind 'set menu-complete-display-prefix on'


###############
### OPTIONS ###
###############

stty -ixon

shopt -s checkwinsize

HISTFILEDIR="$XDG_STATE_HOME/bash"
[ -d "$HISTFILEDIR" ] || mkdir -p "$HISTFILEDIR"
HISTFILE="$HISTFILEDIR/history"

export HISTFILESIZE=10000
export HISTSIZE=500
export HISTTIMEFORMAT="%F %T"

shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
shopt -s cmdhist # Save multi-line commands as one
HISTCONTROL=ignoredups:erasedups:ignorespace

shopt -s extglob   
shopt -s globstar # Recursive globbing (**/*)

if [[ $iatest -gt 0 ]]; then bind "set bell-style visible"; fi
shopt -s checkjobs # Notify on background jobs


#################
##### VI MODE ###
#################

set -o vi # built-in vim mode
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
### Note: If ble.sh is active, cursor changes are usually handled automatically.
### This fallback works for native Readline:
bind 'set show-mode-in-prompt on'
bind 'set vi-ins-mode-string \1\e[5 q\2'
bind 'set vi-cmd-mode-string \1\e[1 q\2'

# Yank to the system clipboard
# if command -v wl-copy &> /dev/null; then
#     bind -m vi-command 'x: "y": "\e[wl-copy\n"' # Custom binding fallback or handled via clipboards
# fi


##################
##### BINDKEYS ###
##################

bind '"\e[3;5~": kill-word'           # ctrl+del
bind '"\eH": backward-kill-word'      # ctrl+backspace (depends on terminal emulator)
bind '"\e[3~": delete-char'           # del
bind '"\e[107;6u": kill-whole-line'   # ctrl+shift+k
bind '"\e[H": beginning-of-line'      # home
bind '"\e[F": end-of-line'            # end
bind '"\e[1;5D": backward-word'       # ctrl+left
bind '"\e[1;5C": forward-word'        # ctrl+right
