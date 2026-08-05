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

# Alias's for multiple directory listing commands
alias la='ls -l --almost-all --human-readable'                       # show hidden files (-Alh)
alias lx='ls -l --sort=extension --ignore-backups --human-readable'  # sort by extension (-lXBh)
alias lk='ls -l --sort=size --reverse --human-readable'              # sort by size (-lSrh)
alias lc='ls -l --sort=time --time=ctime --reverse --human-readable' # sort by change time (-ltcrh)
alias lu='ls -l --sort=time --time=atime --reverse --human-readable' # sort by access time (-lturh)
alias lr='ls -l --recursive --human-readable'                        # recursive ls (-lRh)
alias lt='ls -l --sort=time --reverse --human-readable'              # sort by date (-ltrh)
alias lm='ls -l --all --human-readable | more'                       # pipe through 'more' (-alh)
alias lw='ls -x --almost-all --human-readable'                       # wide listing format (-xAh)
alias ll='ls -l --classify --size'                                   # long listing format (-Fls)
alias labc='ls -l --all --indicator-style=slash'                     # alphabetical sort (-lap)
alias lf='ls -l | grep --invert-match "^d"'                          # files only
alias ldir='ls -l | grep "^d"'                                       # directories only
alias lla='ls -l --almost-all'                                       # List and Hidden Files (-Al)
alias las='ls --almost-all'                                          # Hidden Files (-A)
alias lls='ls -l'                                                    # List (-l)

# alias chmod commands
alias mx='chmod a+x '
alias 000='chmod --recursive 000 '
alias 644='chmod --recursive 644 '
alias 666='chmod --recursive 666 '
alias 755='chmod --recursive 755 '
alias 777='chmod --recursive 777 '

alias openports='netstat --numeric --all --programs --extend --inet' # Show open ports

# Alias's for safe and forced reboots
alias rebootsafe='sudo shutdown --reboot now'
alias rebootforce='sudo shutdown --reboot -n now'

# Alias's to show disk space and space used in a folder
alias folders='du --human-readable --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du --summarize -k | sort --numeric-sort --reverse'
alias mountedinfo='df --human-readable --print-type'

# Alias's for archives
alias mktar='tar --create --verbose --file='
alias mkbz2='tar --create --verbose --bzip2 --file='
alias mkgz='tar --create --verbose --gzip --file='
alias untar='tar --extract --verbose --file='
alias unbz2='tar --extract --verbose --bizp2 --file='
alias ungz='tar --extract --verbose --gzip --file='

# SHA1
alias sha1='openssl sha1'

# KITTY - alias to be able to use kitty features when connecting to remote servers(e.g use tmux on remote server)
alias kssh="kitty +kitten ssh"

# Alias to cleanup unused docker containers, images, networks, and volumes
alias docker-clean=' \
  docker container prune --force ; \
  docker image prune --force ; \
  docker network prune --force ; \
  docker volume prune --force '
