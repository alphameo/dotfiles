# Simple aliases
alias sudo 'sudo '
alias fzf 'fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias pacman 'pacman --color=always'
alias bat 'bat --style=plain --pager=never'
# alias ls 'ls --color=always'
alias ls 'ls --classify --human-readable --color=always'
alias rg 'rg --color=always'
# alias cdr '__zoxide_z'
alias cdr "__zoxide_zi"
alias eza 'eza --color=always --icons=always'
alias cp 'cp --interactive'
alias mv 'mv --interactive'
alias trash 'trash --verbose'
alias mkdir 'mkdir --parents'
alias ping 'ping --count 10'
alias less 'less --RAW-CONTROL-CHARS'
alias tree 'tree -CAhF --dirsfirst'

# Function-like aliases
alias h 'history | grep' # Search command line history
alias f 'find . | grep' # Search files in the current folder

alias countfiles 'echo "$(find . -type f 2>/dev/null | wc -l) files"; echo "$(find . -type l 2>/dev/null | wc -l) links"; echo "$(find . -type d 2>/dev/null | wc -l) directories"'
alias logs 'sudo find /var/log -type f -exec file {} \; | grep "text" | cut --delimiter=" " --fields=1 | sed --expression="s/:\$//g" | grep --invert-match "[0-9]\$" | xargs tail --follow'
alias diskspace 'du --separate-dirs | sort --numeric-sort --reverse | more'
alias folders 'du --human-readable --max-depth=1'
alias folderssort 'find . -maxdepth 1 -type d -print0 | xargs -0 du --summarize -k | sort --numeric-sort --reverse'
alias mountedinfo 'df --human-readable --print-type'
alias openports 'netstat --numeric --all --programs --extend --inet' # Show open ports
alias docker-clean 'docker container prune --force; docker image prune --force; docker network prune --force ; docker volume prune --force'

# Abbreviations
abbr --add nv 'nvim'
abbr --add ff 'fastfetch'
abbr --add sudonv 'sudoedit'
abbr --add e 'eza'
abbr --add ldoc 'lazydocker'
abbr --add lgit 'lazygit'
abbr --add da 'date "+%Y-%m-%d %A %T %Z"'
abbr --add treed 'tree -CAFd'
abbr --add sha1 'openssl sha1'
abbr --add kssh 'kitty +kitten ssh' # alias to be able to use kitty features when connecting to remote servers(e.g use tmux on remote server)

abbr --add la 'ls -l --almost-all --human-readable'                       # show hidden files (-Alh)
abbr --add lx 'ls -l --sort=extension --ignore-backups --human-readable'  # sort by extension (-lXBh)
abbr --add lk 'ls -l --sort=size --reverse --human-readable'              # sort by size (-lSrh)
abbr --add lc 'ls -l --sort=time --time=ctime --reverse --human-readable' # sort by change time (-ltcrh)
abbr --add lu 'ls -l --sort=time --time=atime --reverse --human-readable' # sort by access time (-lturh)
abbr --add lr 'ls -l --recursive --human-readable'                        # recursive ls (-lRh)
abbr --add lt 'ls -l --sort=time --reverse --human-readable'              # sort by date (-ltrh)
abbr --add lm 'ls -l --all --human-readable | more'                       # pipe through 'more' (-alh)
abbr --add lw 'ls -x --almost-all --human-readable'                       # wide listing format (-xAh)
abbr --add ll 'ls -l --classify --size'                                   # long listing format (-Fls)
abbr --add labc 'ls -l --all --indicator-style=slash'                     # alphabetical sort (-lap)
abbr --add lf 'ls -l | grep --invert-match "^d"'                          # files only
abbr --add ldir 'ls -l | grep "^d"'                                       # directories only
abbr --add lla 'ls -l --almost-all'                                       # List and Hidden Files (-Al)
abbr --add las 'ls --almost-all'                                          # Hidden Files (-A)
abbr --add lls 'ls -l'                                                    # List (-l)

abbr --add mx 'chmod a+x'
abbr --add 000 'chmod --recursive 000'
abbr --add 644 'chmod --recursive 644'
abbr --add 666 'chmod --recursive 666'
abbr --add 755 'chmod --recursive 755'
abbr --add 777 'chmod --recursive 777'

abbr --add mktar 'tar --create --verbose --file'
abbr --add mkbz2 'tar --create --verbose --bzip2 --file'
abbr --add mkgz 'tar --create --verbose --gzip --file'
abbr --add untar 'tar --extract --verbose --file='
abbr --add unbz2 'tar --extract --verbose --bzip2 --file'
abbr --add ungz 'tar --extract --verbose --gzip --file'
