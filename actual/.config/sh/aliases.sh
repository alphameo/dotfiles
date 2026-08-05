alias sudo='sudo '
alias fzf='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias pacman='pacman --color=always'
alias sudonv='sudoedit'
alias bat='bat --style=plain --pager=never'
# alias ls='ls --color=always'
alias ls='ls --classify --human-readable --color=always'
alias rg='rg --color=always'
# alias cdr='__zoxide_z'
alias cdr="__zoxide_zi"
alias eza='eza --color=always --icons=always'
alias cp='cp --interactive'
alias mv='mv --interactive'
alias trash='trash --verbose'
alias mkdir='mkdir --parents'
alias ping='ping --count 10'
alias less='less --RAW-CONTROL-CHARS'
alias tree='tree -CAhF --dirsfirst'

alias h='history | grep ' # Search command line history
alias p='ps aux | grep ' # Search running processes
alias f='find . | grep ' # Search files in the current folder

alias topcpu='ps -A --format=pcpu,pid,user,args | sort --key=1 --reverse | head -10'
alias countfiles='echo "$(find . -type f 2>/dev/null | wc -l) files"; echo "$(find . -type l 2>/dev/null | wc -l) links"; echo "$(find . -type d 2>/dev/null | wc -l) directories"'
alias logs='sudo find /var/log -type f -exec file {} \; | grep "text" | cut --delimiter=" " --fields=1 | sed --expression="s/:$//g" | grep --invert-match "[0-9]$" | xargs tail --follow'
alias diskspace='du --separate-dirs | sort --numeric-sort --reverse | more'

alias nv='nvim'
alias ff='fastfetch'
alias e='eza'
alias ldoc='lazydocker'
alias lgit='lazygit'
alias da='date "+%Y-%m-%d %A %T %Z"'
alias psall='ps auxf'
alias treed='tree -CAFd'

source "$HOME/.config/sh/extended_aliases.sh"
