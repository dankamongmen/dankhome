#export window_manager=compiz

#pidgin -n &
#gnome-sound-applet &
#gmpc --start-hidden &
#screenletsd --cli run clearweather
#screenletsd --cli run windowlist
#exec compiz --replace
eval `gnome-keyring-daemon -s -d`
avant-window-navigator --startup --startup-delay 1 &
gnome-session &
wpa_gui -t &
compiz --replace
