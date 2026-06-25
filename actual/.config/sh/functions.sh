# eza tree
et() {
  local eza_cmd="eza --tree --color=always"
  local params="$*"
  case "$1" in ''|*[!0-9]*)
      eval "$(printf '%s --level=1 %s\n' "$eza_cmd" "$params")";;
  *)
      eval "$(printf '%s --level=%s\n' "$eza_cmd" "$params")";;
  esac
}

# yazi
# https://yazi-rs.github.io/docs/quick-start#shell-wrapper
function fm() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# python venv
hvenv() {
  echo "Current venv: $VIRTUAL_ENV
USAGE:
$ hvenv                 # shows venv help
$ lsvenv                # list available venvs
$ mkvenv <myvirtualenv> # creates venv under $VENV_HOME
$ venv <myvirtualenv>   # activates venv
$ deactivate            # deactivates venv
$ rmvenv <myvirtualenv> # removes venv"
}

lsvenv() {
  ls -1 "$VENV_HOME"
}

venv() {
  if [ $# -eq 0 ]
    then
      hvenv
    else
      source "$VENV_HOME/$1/bin/activate"
  fi
}

mkvenv() {
  if [ $# -eq 0 ]
    then
      echo "Please provide venv name"
    else
      python3 -m venv "$VENV_HOME/$1"
  fi
}

rmvenv() {
  if [ $# -eq 0 ]
    then
      echo "Please provide venv name"
    else
      rm -r "$VENV_HOME/$1"
  fi
}
