# ~/.zprofile: executed by zsh(1) for login shells.
# see /usr/share/doc/zsh/examples for examples.

umask 027

# Debian's sensible-browser(1) uses BROWSER, causing gnome-terminal and
# xfce4-terminal both to invoke links2 under this config...
if set | grep ^SSH_TTY > /dev/null || tty | grep -v /pts/ > /dev/null ; then
	if command -v w3m > /dev/null 2>&1 ; then
		export BROWSER="w3m"
	elif command -v links2 > /dev/null 2>&1 ; then
		export BROWSER="links2"
	elif command -v links > /dev/null 2>&1 ; then
		export BROWSER="links"
	fi
fi

# Largely copied from the gpg-agent man page
AGENT=`command -v gpg-agent 2>/dev/null`
if [ -r $HOME/.secret/.gnupg/secring.gpg -a -x "$AGENT" ] ; then
	if test -f $HOME/.gpg-agent-info && kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info` 2>/dev/null; then
		GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info`
		export GPG_AGENT_INFO
	else
		eval `$AGENT --daemon`
		echo $GPG_AGENT_INFO >$HOME/.gpg-agent-info
		unset AGENT
	fi
fi
unset AGENT

# Turn off beeps in virtual console without disabling speaker entirely
if tty | grep ^/dev/tty > /dev/null ; then
	# OS X sshd puts you on e.g. /dev/ttysXXX, and lacks setterm
	if command -v setterm > /dev/null ; then
		echo -n "Disabling console beep..."
		setterm -blength 0
		echo "done."
	fi
fi

# Assume white-on-black terminal (see colors(3NCURSES), ncurses (3NCURSES))
export NCURSES_ASSUMED_COLORS=7,0

. "$HOME/.cargo/env"
