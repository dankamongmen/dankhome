#!/bin/sh

# called by xinit when startx is used from the console
[ -r /etc/xprofile ] && . /etc/xprofile
[ -r ~/.xprofile ] && . ~/.xprofile

# /etc/X11/xinit/xinitrc on Debian sources /etc/X11/Xsession, which in turn
# creates a logfile and sources the contents of /etc/X11/Xsession.d/.
if [ -r /etc/X11/xinit/xinitrc ] ; then
 echo /etc/X11/xinit/xinitrc
 #. /etc/X11/xinit/xinitrc
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  . "$f"
 done
 unset f
fi

# must serialize
xrdb -merge ~/.Xresources

# for launching compiz directly
#setxkbmap -option terminate:ctrl_alt_bksp
#xfce4-panel &
#xscreensaver -nosplash &
#exec fusion-icon -f

# for launching compiz through xfce4-session/xsession
exec startxfce4
