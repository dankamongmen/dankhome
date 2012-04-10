export WINDOW_MANAGER=compiz

#pidgin -n &
#gnome-sound-applet &
#gmpc --start-hidden &
#screenletsd --cli run ClearWeather
#screenletsd --cli run Windowlist
#exec compiz --replace
eval `gnome-keyring-daemon -s -d`
avant-window-navigator --startup --startup-delay 1 &
gnome-session &
wpa_gui -t &
compiz --replace
