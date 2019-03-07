# called by /etc/X11/Xsession when the default is used from light-dm

# for launching compiz directly
setxkbmap -option terminate:ctrl_alt_bksp
xfce4-panel &
xscreensaver &
exec compiz

# for launching compiz through xfce4-session
#exec xfce4-session
