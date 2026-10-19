# eza tree
function et
    if test (count $argv) -eq 0
        eza --tree --level=1 --color=always
    else if string match -qr '^[0-9]+$' $argv[1]
        eza --tree --level=$argv[1] --color=always
    else
        eza --tree --level=1 --color=always $argv
    end
end

# https://yazi-rs.github.io/docs/quick-start#shell-wrapper
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	command rm -f -- "$tmp"
end

# python venv
function hvenv
    echo "Current venv: $VIRTUAL_ENV
USAGE:
  hvenv                 # shows venv help
  lsvenv                # list available venvs
  mkvenv <name>         # create venv under \$VENV_HOME
  venv <name>           # activate venv
  deactivate            # deactivate
  rmvenv <name>         # remove venv"
end

function lsvenv
    ls -1 $VENV_HOME
end

function venv
    if test (count $argv) -eq 0
        hvenv
    else
        source "$VENV_HOME/$argv[1]/bin/activate.fish"
    end
end

function mkvenv
    if test (count $argv) -eq 0
        echo "Please provide venv name"
    else
        python3 -m venv "$VENV_HOME/$argv[1]"
    end
end

function rmvenv
    if test (count $argv) -eq 0
        echo "Please provide venv name"
    else
        rm -rf "$VENV_HOME/$argv[1]"
    end
end
