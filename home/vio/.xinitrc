DEFAULT_SESSION=awesome
# make the mouse work right on my thinkpad in lucid
xinput set-prop 'TPPS/2 IBM TrackPoint' "Evdev Wheel Emulation" 1
xinput set-prop 'TPPS/2 IBM TrackPoint' "Evdev Wheel Emulation Button" 2
xinput set-prop 'TPPS/2 IBM TrackPoint' "Evdev Wheel Emulation Timeout" 200

echo 1500 > /sys/class/backlight/intel_backlight/brightness
feh --bg-scale /home/develop/dwm/dwm-bg02.png

#while true; do
#	bat=`acpi | cut -d' ' -f4-5`
#	xsetroot -name "$bat | $( date +"%a %F %R" )"
#	sleep 1s
#done &

#~/dwm/stat &
/home/develop/thinkpad_dwm_stat/stat &
xmodmap ~/.xmodmaprc

exec dwm
#exec awesome
#exec gnome-session
