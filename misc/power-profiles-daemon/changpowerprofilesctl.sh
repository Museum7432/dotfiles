#!/bin/bash
# /usr/local/bin/changpowerprofilesctl.sh
if [[ "$new_mode" == "performance" || "$new_mode" == "balanced" || "$new_mode" == "power-saver" ]]; then
	gdbus call --system --dest net.hadess.PowerProfiles --object-path /net/hadess/PowerProfiles --method org.freedesktop.DBus.Properties.Set 'net.hadess.PowerProfiles' 'ActiveProfile' "<'$new_mode'>" 
	su - arch -c "env DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /usr/bin/notify-send set\ power\ profile\ to\ $new_mode"
fi
