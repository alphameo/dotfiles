#!/usr/bin/bash

# check /home/a1pha/.config/systemd/user/battery_notify.service, /home/a1pha/.config/systemd/user/battery_notify.timer
# systemctl --user enable --now battery-notify.service
# journalctl --user -u check-battery.service

BATTERY_INFO=$(acpi -b)
BATTERY_LEVEL=$(acpi -b | grep -P -o '[0-9]+(?=%)')
STATUS=$(acpi -b | grep -oP 'Charging|Discharging')

CRITICAL=5
WARNING=10
NOTICE=20

if [[ $STATUS =~ "Discharging" ]]; then
    case $BATTERY_LEVEL in
    $CRITICAL) dunstify -a "battery-critical" "$BATTERY_LEVEL" "CRITICAL: Battery almost dead!" ;;
    $WARNING) dunstify -a "battery-warning" "$BATTERY_LEVEL" "Warning: Low battery!" ;;
    $NOTICE) dunstify -a "battery-notice" "$BATTERY_LEVEL" "Notice: Battery running low" ;;
    esac
fi
