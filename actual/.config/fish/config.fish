if status is-interactive
    source "$XDG_CONFIG_HOME/fish/aliases"

    # https://github.com/ajeetdsouza/zoxide#Installation
    zoxide init fish | source

    # https://github.com/junegunn/fzf#setting-up-shell-integration
    fzf --fish | source

    set -gx FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"
    set -gx FZF_DEFAULT_OPTS "--height=50% --layout=default --border=rounded --preview-window=right:60%:wrap --color=hl:#2dd4bf"
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    set -gx FZF_CTRL_T_OPTS "
        --preview 'bat --color=always --style=plain,numbers --line-range :500 {}'
        --bind 'ctrl-/:change-preview-window(down|hidden|)'"
    set -gx FZF_ALT_C_COMMAND "fd --type=d --hidden --strip-cwd-prefix --exclude .git"
    set -gx FZF_ALT_C_OPTS "--preview 'eza --icons=always --tree --color=always {} | head -200'"

    # https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship
    starship init fish | source


    ########################
    ### CUSTOM FUNCTIONS ###
    ########################

    source "$HOME/.config/fish/functions.fish"


    ###############
    ### OPTIONS ###
    ###############

    # disbale Software Flow Control ctrl+s (to enable: stty -ixoff)
    stty -ixon

    set fish_greeting ""


    ###############
    ### VI MODE ###
    ###############

    fish_vi_key_bindings
end
