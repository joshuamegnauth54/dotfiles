# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.
export PS1="\[$(tput bold)\]\[\033[38;5;81m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;206m\]\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[38;5;6m\][\w]\[$(tput sgr0)\]: \[$(tput sgr0)\]"

# Updated PATH
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:/usr/lib/root/9999/bin:${NPM_PACKAGES}/bin"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

# Editors, pager, et cetera
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less" # I think nvimpager doesn't work with ANSI escape sequences for colors
export BROWSER="firefox"

# SDL
export SDL_AUDIODRIVER="pulseaudio"
export SDL_VIDEODRIVER="x11"

# Java
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -swing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# Program specific
export PYCHARM_JDK=`java-config -O`

# double entries in the shell history
export HISTCONTROL="$HISTCONTROL erasedups:ignoreboth"

# do not overwrite files when redirecting output by default.
set -o noclobber

# Qt environmental variables
QT_AUTO_SCREEN_SCALE_FACTOR=1

# wrap these commands for interactive use to avoid accidental overwrites.
rm() { command rm -i "$@"; }
cp() { command cp -i "$@"; }
mv() { command mv -i "$@"; }
ln() { command ln -i "$@"; }
export SCIPY_PIL_IMAGE_VIEWER=nomacs

# Aliases
alias ls='ls -Fh --color=auto'
alias ll="ls -la"

alias df='df -kTh'
alias sudo='sudo '
alias diff='diff --color=auto'
alias less='less --mouse'
alias grep='grep --color=auto'
alias ip='ip --color=auto'

emergeupd () {
	emerge --update --newuse --deep --fetchonly --with-bdeps=y --ask --backtrack=30 "$@" @world &&
	emerge --update --newuse --verbose --deep --keep-going --with-bdeps=y --quiet-build --backtrack=30 "$@" @world
}

emergefinst () {
	emerge --ask --fetchonly --verbose "$@" &&
	emerge --quiet-build "$@"
}

emergeinst () {
	emerge --ask --verbose --quiet-build "$@"
}

# Options
shopt -s checkwinsize # Automatically update max lines/columns when terminal emulator is resized
shopt -s checkhash
shopt -s dirspell # Autocorrects misspelled directory names during tab completion
shopt -s extglob # Required for completion?
shopt -s histappend
shopt -s histreedit
shopt -s histverify
set -o noclobber # Don't clobber files with > (override with >|)
set -o ignoreeof # EOF (i.e. ctrl-d) doesn't exit the shell

# Just so I don't forget:
set -o vi
# set -o emacs
