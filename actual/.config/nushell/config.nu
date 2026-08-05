source ~/.config/nushell/aliases.nu

# https://github.com/ajeetdsouza/zoxide#Installation
source ~/.zoxide.nu


# https://github.com/junegunn/fzf#setting-up-shell-integration
# NOTE: Nushell does not support piping into source, so the install script generates a file in the autoload directory.
# If you didn't use the install script, you can manually set it up:
mkdir ($nu.default-config-dir | path join "autoload")
fzf --nushell | save -f ($nu.default-config-dir | path join "autoload" "_fzf_integration.nu")

$env.FZF_DEFAULT_COMMAND = "fd --hidden --strip-cwd-prefix --exclude .git"
$env.FZF_DEFAULT_OPTS = "--height=50% --layout=default"
$env.FZF_CTRL_T_COMMAND = "$env.FZF_DEFAULT_COMMAND"
$env.FZF_CTRL_T_OPTS = "
  --preview 'bat --color=always --style=plain,numbers --line-range :500 {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
$env.FZF_ALT_C_COMMAND = "fd --type=d --hidden --strip-cwd-prefix --exclude .git"
$env.FZF_ALT_C_OPTS = "--preview 'eza --icons=always --tree --color=always {} | head -200'"

# https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")


########################
### CUSTOM FUNCTIONS ###
########################

overlay use functions.nu


###############
### OPTIONS ###
###############
# NOTE: See $env.config | table -e | bat -p

# disbale Software Flow Control ctrl+s (to enable: stty -ixoff)
stty -ixon
$env.config.show_banner = false
$env.config.use_kitty_protocol = true

###############
### VI MODE ###
###############

$env.config.edit_mode = "vi"

$env.config.cursor_shape = {
    emacs: line
    vi_insert: line
    vi_normal: block
}
