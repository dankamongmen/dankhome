# .bashrc -- executed by bash(1) for non-login shells
# last synced against debian's /etc/skel/.bashrc Sat Aug  6 14:47:18 EDT 2005

# This file must not produce output, as it is run by all instances of the shell
# including ssh's file transfer and remote command execution modes!

# if not running interactively, do nothing
#if [ -n "$PS1" ] ; then

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTFILESIZE=10000

# check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

DANKRC="$HOME/.svnhome"
[ -d $DANKRC ] || DANKRC=$HOME

if [ "$TERM" != "dumb" ] ; then
	if [ -n "`ls --version 2> /dev/null | grep '(GNU coreutils)'`" ] ; then
		if [ -r $DANKRC/dankcolors ] ; then
			eval "`dircolors -b $DANKRC/dankcolors`";
		else
			eval "`dircolors -b`";
		fi
		alias ls='ls --color=auto';
	elif [ "`uname`" == "FreeBSD" ] ; then
		export CLICOLOR=yes
		# foregroundbackground pairs for:
		#  directory (Ea) softlink (Ga) socket (Fa) pipe (da) exec (Ca)
		#  block dev (Da) char dev (Da) setuid (Hb) setgid (ab)
		#  directory writable by others with sticky bit (HC)
		#  directory writable by others sans sticky bit (aC)
		export LSCOLORS=EaGaFadaCaDaDaHbabHCaC
	fi
fi

# default creation policy of mode_t & rwxr-xr-x
umask 022

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Construct our PATH. Use PATHDIRS to list all directories wanted, in ascending
# order of search priority (least important first). After passing sanity
# checks, they will be prepended into PATH.
PATHDIRS="$PATH"
PATHDIRS="$PATHDIRS /usr/games" # Nethack!
# FIXME only do this on machines where we wish to use Java
PATHDIRS="$PATHDIRS /usr/local/java/bin"
# FIXME only do these on machines where we wish to use X
PATHDIRS="$PATHDIRS /usr/X11R6/bin /usr/X11R6/sbin"
PATHDIRS="$PATHDIRS /usr/X11/bin /usr/X11/sbin"
# End FIXME
PATHDIRS="$PATHDIRS /bin /sbin"
PATHDIRS="$PATHDIRS /usr/bin /usr/sbin"
PATHDIRS="$PATHDIRS /usr/local/bin /usr/local/sbin"
PATHDIRS="$PATHDIRS $HOME/bin $HOME/sbin"

PATHFINAL=""
for pathdir in $PATHDIRS ; do
	# FIXME check that we have list directory permissions
	# FIXME check that realpath $pathdir doesn't equal something else
	if [ -d $pathdir ] ; then
		if [ -n "$PATHFINAL" ] ; then
			PATHFINAL="$pathdir:$PATHFINAL"
		else
			PATHFINAL="$pathdir"
		fi
	fi
done
PATH=$PATHFINAL
unset PATHFINAL

unset pathdir
unset PATHDIRS

# if we've a host-specific bashrc, source it
if [ -r $DANKRC/.bashrc-$HOSTNAME ] ; then
	. $DANKRC/.bashrc-$HOSTNAME
fi

for i in $DANKRC/.bashrc_helpers/* ; do
	. "$i"
done
unset i

if [ -z "$TMPDIR" ] ; then
	TMPDIR=$HOME
	[ ! -d /tmp ] || export TMPDIR=/tmp
	[ ! -d $HOME/tmp ] || export TMPDIR=$HOME/tmp
fi

if ! `which vim > /dev/null` ; then
	if ! echo "`readlink -f \`which vi\``" | grep vim > /dev/null ; then
		alias vi=vim
	fi
else
	alias vi=vim
fi

# from gnupg-agent(1)
export GPG_TTY=`tty`

# See http://www.xcombinator.com/2008/07/23/mac-os-x-color-showing-escwhatever-for-git-diff-colors-and-more/
# and the less(1) man page.
export LESS="-eirX"

alias apt-file="apt-file -c ~/var/cache/apt-file"
alias grep="grep --color"
which xml > /dev/null 2>&1 || alias xml="xmlstarlet"

export LANG=en_US.UTF-8
export NNTPSERVER=news.gmane.org

unset MAILCHECK
unset MAILPATH
unset MAIL

unset DANKRC