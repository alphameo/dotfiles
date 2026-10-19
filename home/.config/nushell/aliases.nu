# Simple aliases
alias sudo = ^sudo
alias fzf = ^fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"
alias pacman = ^pacman --color=always
alias bat = ^bat --style=plain --pager=never
alias ls = ^ls --classify --human-readable --color=always
alias rg = ^rg --color=always
alias cdr = __zoxide_zi
alias eza = ^eza --color=always --icons=always
alias cp = ^cp --interactive
alias mv = ^mv --interactive
alias trash = ^trash --verbose
alias mkdir = ^mkdir --parents
alias ping = ^ping --count 10
alias less = ^less --RAW-CONTROL-CHARS
alias tree = ^tree -CAhF --dirsfirst

# Function-like aliases
def h [pattern: string] {
    history | where command =~ $pattern
}

def f [pattern: string] {
    ^find . | ^grep $pattern
}

def countfiles [] {
    print $"(^find . -type f | lines | length) files"
    print $"(^find . -type l | lines | length) links"
    print $"(^find . -type d | lines | length) directories"
}

def logs [] {
    ^sudo find /var/log -type f -exec file {} \;
    | ^grep "text"
    | ^cut --delimiter=" " --fields=1
    | ^sed --expression="s/:\$//g"
    | ^grep --invert-match "[0-9]\$"
    | ^xargs tail --follow
}

alias diskspace = ^du --separate-dirs | ^sort --numeric-sort --reverse | ^more
alias folders = ^du --human-readable --max-depth=1

def folderssort [] {
    ^find . -maxdepth 1 -type d -print0 | ^xargs -0 du --summarize -k | ^sort --numeric-sort --reverse
}

alias mountedinfo = ^df --human-readable --print-type
alias openports = ^netstat --numeric --all --programs --extend --inet # Show open ports

def docker-clean [] {
    ^docker container prune --force
    ^docker image prune --force
    ^docker network prune --force
    ^docker volume prune --force
}

# Abbreviations
$env.config.abbreviations = {
    nv: "^nvim"
    ff: "^fastfetch"
    sudonv: "^sudoedit"
    e: "^eza"
    ldoc: "^lazydocker"
    lgit: "^lazygit"
    da: '^date "+%Y-%m-%d %A %T %Z"'
    treed: "^tree -CAFd"
    sha1: "^openssl sha1"
    kssh: "^kitty +kitten ssh"

    la: "^ls -l --almost-all --human-readable"
    lx: "^ls -l --sort=extension --ignore-backups --human-readable"
    lk: "^ls -l --sort=size --reverse --human-readable"
    lc: "^ls -l --sort=time --time=ctime --reverse --human-readable"
    lu: "^ls -l --sort=time --time=atime --reverse --human-readable"
    lr: "^ls -l --recursive --human-readable"
    lt: "^ls -l --sort=time --reverse --human-readable"
    lm: "^ls -l --all --human-readable"
    lw: "^ls -x --almost-all --human-readable"
    ll: "^ls -l --classify --size"
    labc: "^ls -l --all --indicator-style=slash"
    lf: "^ls -l | ^grep --invert-match "^d""
    ldir: "^ls -l | ^grep "^d""
    lla: "^ls -l --almost-all"
    las: "^ls --almost-all"
    lls: "^ls -l"

    mx: "^chmod a+x"
    "000": "^chmod --recursive 000"
    "644": "^chmod --recursive 644"
    "666": "^chmod --recursive 666"
    "755": "^chmod --recursive 755"
    "777": "^chmod --recursive 777"

    mktar: "^tar --create --verbose --file"
    mkbz2: "^tar --create --verbose --bzip2 --file"
    mkgz: "^tar --create --verbose --gzip --file"
    untar: "^tar --extract --verbose --file="
    unbz2: "^tar --extract --verbose --bzip2 --file"
    ungz: "^tar --extract --verbose --gzip --file"
}
