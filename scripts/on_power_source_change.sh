#!/bin/bash
# ~/.local/bin/on_power_source_change.sh
# automatically set power profile daemon to power_saver and pause syncthing on battery

if /usr/bin/pidof -o %PPID -x "on_power_source_change.sh"; then
    exit 1
fi

# wait for syncthing to start
while ! /usr/bin/pidof /usr/bin/syncthing; do
    /usr/bin/sleep 1
done
/usr/bin/sleep 5

is_on_AC="$(< /sys/class/power_supply/ACAD/online)"

while true; do

    if [[ $is_on_AC == "1" ]]; then
        # if on AC
        # use balanced mode
    	/usr/bin/powerprofilesctl set balanced

        # resume syncthing on AC
    	/usr/bin/syncthingctl resume --all-devs &

        # notify user
        /usr/bin/notify-send -e "plugged in"
    else
        # otherwise, use power-saver on battery
    	/usr/bin/powerprofilesctl set power-saver

        # pause syncthing on battery
    	/usr/bin/syncthingctl pause --all-devs &

    	/usr/bin/notify-send -e "on battery"
    fi

    while true; do
        # power supply status is usually accessed on plugged in or plugged out
        /usr/bin/inotifywait -e access /sys/class/power_supply/ACAD/online

        if [[ $is_on_AC != "$(< /sys/class/power_supply/ACAD/online)" ]]; then
            is_on_AC="$(< /sys/class/power_supply/ACAD/online)"
            break
        fi
    done

done
