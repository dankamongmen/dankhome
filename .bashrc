# .bashrc -- executed by bash(1) for non-login shells
# last synced against debian's /etc/skel/.bashrc Sat Aug  6 14:47:18 EDT 2005

# This file must not produce output, as it is run by all instances of the shell
# including ssh's file transfer and remote command execution modes!

# if not running interactively, do nothing
#if [ -n "$PS1" ] ; then

# Allow $HOME/.svnhome in case we can't keep dankhome within our actual home
# directory. If $HOME/.svnhome doesn't exist, assume we're using $HOME.
DANKRC="$HOME/.svnhome"
[ -d $DANKRC ] || DANKRC=$HOME

# See bash(1) for more options
export HISTCONTROL=erasedups
export HISTFILESIZE=
export HISTSIZE=
export HISTFILE="$DANKRC/.bash_history-$HOSTNAME"
export HISTTIMEFORMAT="[%F %T] "
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
#PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# Append to history file rather than rewriting it
shopt -s histappend
# Allow failed history substitutions to be edited
shopt -s histreedit

# these values are used when setting SHELLOPTS, equivalent to set -o vi
export EDITOR="vim"
export PAGER="less"

# check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

if [ "$TERM" != "dumb" ] ; then
  # alacritty-direct is selected in alacritty.yml
  # kitty-direct is selected in kitty.conf
	#if [ "$TERM" == "xterm" -o "$TERM" == "xterm-256color" ] ; then
	if [ "$TERM" == "xterm" ] ; then
		#export TERM=xterm-256color
    # FIXME only want to do this for VTE-derived terminals
    export TERM=vte-256color
  elif [ "$TERM" == "vte" -o "$TERM" == "xterm-256color" ] ; then
    export TERM=vte-256color
	fi
	if [ -n "`ls --version 2> /dev/null | grep '(GNU coreutils)'`" ] ; then
		if [ -r $DANKRC/dankcolors ] ; then
			eval "`dircolors -b $DANKRC/dankcolors`";
		else
			eval "`dircolors -b`";
		fi
		alias ls='ls --color=auto --quoting-style=literal';
    export S_COLORS=auto # for iostat on arch
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

# Ehhh...I'd rather have my TMPDIR cleaned each boot, I think...
#if [ -z "$TMPDIR" ] ; then
#	TMPDIR=$HOME
#	[ ! -d /tmp ] || export TMPDIR=/tmp
#	[ ! -d $HOME/tmp ] || export TMPDIR=$HOME/tmp
#fi

if ! `which vim > /dev/null` ; then
	if ! echo "`readlink -f \`which vi\``" | grep vim > /dev/null ; then
		alias vi=vim
	fi
else
	alias vi=vim
fi

# from gng-agent(1)
export GPG_TTY=`tty`
# gnupg is now auto-started on demand
#if [ -f "${HOME}/.gpg-agent-info" ]; then
#	. "${HOME}/.gpg-agent-info"
#	GPGSOCK="`echo $GPG_AGENT_INFO | cut -d: -f1`"
#	# FIXME relies upon /tmp getting cleared out
#	if [ ! -e "$GPGSOCK" ] ; then
#		unset GPG_AGENT_INFO
#	fi
#	unset GPGSOCK
#fi
#if [ -z "$GPG_AGENT_INFO" ] ; then
#	gpg-agent --daemon "${HOME}/.gpg-agent-info"
#	. "${HOME}/.gpg-agent-info"
#fi
#export GPG_AGENT_INFO

# See http://www.xcombinator.com/2008/07/23/mac-os-x-color-showing-escwhatever-for-git-diff-colors-and-more/
# and the less(1) man page.
export LESS="-eirX"

# coreutils 8.30 went to 12-hour time by default, augh
alias date="date '+%a %d %b %Y %T %Z (%z)'"

# hate hate hate missing submodules
alias gclone="git clone --recurse-submodules"

# ISO 8601 time in observant applications (ls -l, etc.)
export TIME_STYLE=long-iso

alias grep="grep --color"
alias egrep="egrep --color"
which xml > /dev/null 2>&1 || alias xml="xmlstarlet"

export LANG=en_US.UTF-8
export NNTPSERVER=news.gmane.org

# Get a default theme for QT apps (requires running qt5ct to configure)
export QT_QPA_PLATFORMTHEME=qt5ct

# enable programmable completion features
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#	. /etc/bash_completion
#fi

# taken from https://wiki.archlinux.org/index.php/Color_output_in_console#man
man() {
    LESS_TERMCAP_md=$'\e[01;35m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

unset MAILCHECK
unset MAILPATH
unset MAIL

unset DANKRC
