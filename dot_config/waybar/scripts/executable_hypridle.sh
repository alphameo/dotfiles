ENABLED="<span color='#74c7ec'>󰒲</span> "
DISABLED="<span color='#f38ba8'>󰒳</span> "

INP=$@
function check {
  if pidof hypridle >/dev/null; then
    echo $ENABLED
  else
    echo $DISABLED
  fi
}

function toggle {
  if pidof hypridle >/dev/null; then
    pkill hypridle
  else
    hypridle &
  fi
}

if [[ $INP == "check" ]]; then
  check
elif [[ $INP == "toggle" ]]; then
  toggle
else
  exit 1
fi
