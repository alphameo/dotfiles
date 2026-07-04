#!/usr/bin/bash

# softlinks to /etc/systemd/user/...
sudo ln -rs ~/.config/manual/systemd/user/battery-notify.service /etc/systemd/user/battery-notify.service
sudo ln -rs ~/.config/manual/systemd/user/battery-notify.timer /etc/systemd/user/battery-notify.timer

systemctl --user enable --now battery-notify.service
systemctl --user enable --now battery-notify.timer
