# called by /etc/X11/Xsession when the default is used from light-dm

setxkbmap -option terminate:ctrl_alt_bksp
exec compiz
