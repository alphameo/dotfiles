# https://github.com/ajeetdsouza/zoxide#Installation
zoxide init nushell | save -f ~/.zoxide.nu

# https://wiki.archlinux.org/title/XDG_Base_Directory#User_directories
$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.XDG_CACHE_HOME = $"($env.HOME)/.cache"
$env.XDG_DATA_HOME = $"($env.HOME)/.local/share"
$env.XDG_STATE_HOME = $"($env.HOME)/.local/state"

# https://wiki.archlinux.org/title/Environment_variables#Default_programs
$env.EDITOR = "nvim"
$env.SUDO_EDITOR = "nvim"
$env.VISUAL = "nvim"
$env.BROWSER = "zen-browser"
$env.PAGER = "less"
$env.TERMINAL = 'kitty'

$env.LF_CONFIG_HOME = $env.XDG_CONFIG_HOME

$env.NPM_CONFIG_USERCONFIG = $"($env.XDG_CONFIG_HOME)/npm/npmrc"

$env.PRETTIERD_DEFAULT_CONFIG = $"($env.XDG_CONFIG_HOME)/nvim/utils/prettierrc.json"

$env.ESLINT_DEFAULT_CONFIG = $"($env.XDG_CONFIG_HOME)/nvim/utils/eslintrc.js"

$env.MARKDOWNLINT_DEFAULTCONFIG = $"($env.XDG_CONFIG_HOME)/nvim/utils/markdown-lint-cli2.yaml"

$env.GNUPGHOME = $"($env.XDG_CONFIG_HOME)/gnupg"
$env.GPG_TTY = (^tty)

$env.JAVA_HOME = "/usr/lib/jvm/java-25-openjdk"

$env.VENV_HOME = $"($env.HOME)/.virtualenvs"
if not ($env.VENV_HOME | path exists) {
    ^mkdir $env.VENV_HOME
}

$env.TEXMFHOME = $"($env.XDG_DATA_HOME)/texmf"
$env.TEXMFVAR = $"($env.XDG_CACHE_HOME)/texlive/texmf-var"
$env.TEXMFCONFIG = $"($env.XDG_CONFIG_HOME)/texlive/texmf-config"

$env.XCURSOR_PATH = $"($env.XCURSOR_PATH):($env.XDG_DATA_HOME)/icons"

^mkdir -p $"($env.XDG_DATA_HOME)/wineprefixes"
$env.WINEPREFIX = $"($env.XDG_DATA_HOME)/wineprefixes/default"

# Native file dialog for electron apps
$env.GTK_USE_PORTAL = 1

$env.EZA_ICONS_AUTO = 1

$env.RAINFROG_CONFIG = $"($env.XDG_CONFIG_HOME)/rainfrog"

$env.STARSHIP_CONFIG = $"($env.XDG_CONFIG_HOME)/starship/config.toml"

# For nmtui theming
$env.NEWT_COLORS = '
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

# To have colors for ls and all grep commands such as grep, egrep and zgrep
$env.CLICOLOR = 1
$env.LS_COLORS = 'no=00:fi=00:di=00;34:ln=31;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# For less theming
$env.LESS_TERMCAP_mb = $'\e[01;31m' # begin blinking
$env.LESS_TERMCAP_md = $'\e[01;31m' # begin bold
$env.LESS_TERMCAP_me = $'\e[0m' # reset
$env.LESS_TERMCAP_se = $'\e[0m' # end standout
$env.LESS_TERMCAP_so = $'\e[01;44;33m' # standout
$env.LESS_TERMCAP_ue = $'\e[0m' # end underline
$env.LESS_TERMCAP_us = $'\e[01;32m' # begin underline
