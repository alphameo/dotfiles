# eza tree
def et [...args] {
    eza --tree --color=always ...$args
}

# https://yazi-rs.github.io/docs/quick-start#shell-wrapper
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	^yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != $env.PWD and ($cwd | path exists) {
		cd $cwd
	}
	rm -fp $tmp
}

# python venv
def hvenv [] {
    print $"Current venv: ($env.VIRTUAL_ENV?)
USAGE:
  hvenv
  lsvenv
  mkvenv <name>
  venv <name>
  deactivate
  rmvenv <name>"
}

def lsvenv [] {
    ls $env.VENV_HOME
}

def mkvenv [name?: string] {
    if ($name | is-empty) {
        print "Please provide venv name"
    } else {
        python3 -m venv ($env.VENV_HOME | path join $name)
    }
}

def rmvenv [name?: string] {
    if ($name | is-empty) {
        print "Please provide venv name"
    } else {
        rm -r ($env.VENV_HOME | path join $name)
    }
}

def --env venv [name?: string] {
    if ($name | is-empty) {
        hvenv
        return
    }

    let root = ($env.VENV_HOME | path join $name)

    $env.VIRTUAL_ENV = $root
    $env.PATH = ($env.PATH | prepend ($root | path join "bin"))
}
