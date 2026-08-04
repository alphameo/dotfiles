// abbr list
abbr "sudo"="sudo "
abbr "fzf"="fzf --preview "bat --color=always --style=numbers --line-range=:500 {}""
abbr pacman='pacman --color=always'
abbr nv='nvim'
abbr sudonv='sudoedit'
abbr bat='bat --style=plain --pager=never'
abbr ls="ls --color=always"
abbr rg='rg --color=always'
# abbr cdr="__zoxide_z"
abbr cdr="__zoxide_zi"
abbr ff='fastfetch'
abbr e='eza --color=always --icons=always'
abbr ldoc='lazydocker'
abbr lgit='lazygit'

abbr da='date "+%Y-%m-%d %A %T %Z"'
abbr cp='cp -i'
abbr mv='mv -i'
abbr trash='trash -v'
abbr mkdir='mkdir -p'
abbr ps='ps auxf'
abbr ping='ping -c 10'
abbr less='less -R'

# Alias's for multiple directory listing commands
abbr ls='ls -Fh --color=always' # add colors and file type extensions
abbr la='ls -Alh'                # show hidden files
abbr lx='ls -lXBh'               # sort by extension
abbr lk='ls -lSrh'               # sort by size
abbr lc='ls -ltcrh'              # sort by change time
abbr lu='ls -lturh'              # sort by access time
abbr lr='ls -lRh'                # recursive ls
abbr lt='ls -ltrh'               # sort by date
abbr lm='ls -alh |more'          # pipe through 'more'
abbr lw='ls -xAh'                # wide listing format
abbr ll='ls -Fls'                # long listing format
abbr labc='ls -lap'              # alphabetical sort
abbr lf="ls -l | egrep -v '^d'"  # files only
abbr ldir="ls -l | egrep '^d'"   # directories only
abbr lla='ls -Al'                # List and Hidden Files
abbr las='ls -A'                 # Hidden Files
abbr lls='ls -l'                 # List

# alias chmod commands
abbr mx='chmod a+x'
abbr 000='chmod -R 000'
abbr 644='chmod -R 644'
abbr 666='chmod -R 666'
abbr 755='chmod -R 755'
abbr 777='chmod -R 777'

# Search command line history
abbr h="history | grep "

# Search running processes
abbr p="ps aux | grep "
abbr topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
abbr f="find . | grep "

# Count all files (recursively) in the current folder
abbr countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

# To see if a command is aliased, a file, or a built-in command
abbr checkcommand="type -t"

# Show open ports
abbr openports='netstat -nape --inet'

# Alias's for safe and forced reboots
abbr rebootsafe='sudo shutdown -r now'
abbr rebootforce='sudo shutdown -r -n now'

# Alias's to show disk space and space used in a folder
abbr diskspace="du -S | sort -n -r |more"
abbr folders='du -h --max-depth=1'
abbr folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
abbr tree='tree -CAhF --dirsfirst'
abbr treed='tree -CAFd'
abbr mountedinfo='df -hT'

# Alias's for archives
abbr mktar='tar -cvf'
abbr mkbz2='tar -cvjf'
abbr mkgz='tar -cvzf'
abbr untar='tar -xvf'
abbr unbz2='tar -xvjf'
abbr ungz='tar -xvzf'

# Show all logs in /var/log
abbr logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# SHA1
abbr sha1='openssl sha1'

abbr clickpaste='sleep 3; xdotool type "$(xclip -o -selection clipboard)"'

# KITTY - alias to be able to use kitty features when connecting to remote servers(e.g use tmux on remote server)
abbr kssh="kitty +kitten ssh"

# Alias to cleanup unused docker containers, images, networks, and volumes
abbr docker-clean=' \
  docker container prune -f ; \
  docker image prune -f ; \
  docker network prune -f ; \
  docker volume prune -f '
