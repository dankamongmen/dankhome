#!/bin/sh

# called by xinit when startx is used from the console
[ -r /etc/xprofile ] && . /etc/xprofile
[ -r ~/.xprofile ] && . ~/.xprofile

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# for launching compiz directly
#setxkbmap -option terminate:ctrl_alt_bksp
#xfce4-panel &
#xscreensaver -nosplash &
#exec fusion-icon -f

# for launching compiz through xfce4-session
exec startxfce4
