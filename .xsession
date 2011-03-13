# X startup common across all machines. Put machine-specific stuff into
# $HOME/bin/start/, where we demux based on hostname.

nvidia-settings --load-config-only
gnome-settings-daemon
# we want to run the compiz process
/usr/bin/compiz --replace --sm-client-id $GDMSESSION &
exec $HOME/bin/start

#/usr/lib/gnome-disk-utility/gdu-notification-daemon &
#/usr/lib/gnome-volume-manager/gnome-volume-manager
#python -u /usr/share/screenlets/Windowlist/WindowlistScreenlet.py &
#python -u /home/dank/src/facebook-notify/facebook-notify.py &
#screenlets-daemon &

# these are now done in bin/start
#wpa_gui -i wlan0 -t &
#gnome-screensaver
#gmpc --start-hidden &
#mail-notification &
#avant-window-navigator -startup
