# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

umask 027

export EDITOR="vim"
export PAGER="less"
# Debian's sensible-browser(1) uses BROWSER, causing gnome-terminal and
# xfce4-terminal both to invoke links2 under this config...
#export BROWSER="links2"

export NNTPSERVER=news.research.sys

#if `tty | grep /dev/tty1$ > /dev/null` ; then
#	for i in `seq 2 7` ; do
#		sudo openvt -u
#	done
#fi

### Added by surfraw. To remove use surfraw-update-path -remove
if [ -d /usr/lib/surfraw ] ; then
	export PATH=$PATH:/usr/lib/surfraw
fi
### End surfraw addition.

# Largely copied from the gpg-agent man page
AGENT=`which gpg-agent 2>/dev/null`
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

[ -r .bashrc ] && . .bashrc