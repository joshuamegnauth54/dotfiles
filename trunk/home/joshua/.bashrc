# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then
    # Shell is non-interactive.  Be done now!
    return
fi

# Put your fun stuff here.
PS1="\[$(tput bold)\]\[\033[38;5;81m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;206m\]\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[38;5;6m\][\w]\[$(tput sgr0)\]: \[$(tput sgr0)\]"
export PS1

# do not overwrite files when redirecting output by default.
set -o noclobber

# wrap these commands for interactive use to avoid accidental overwrites.
rm() { command rm -i "$@"; }
cp() { command cp -i "$@"; }
mv() { command mv -i "$@"; }
ln() { command ln -i "$@"; }

# Aliases
alias ls='ls -Fh --color=auto'
alias ll="ls -la"
alias df='df -kTh'
alias sudo='sudo '
alias diff='diff --color=auto'
alias less='less --mouse'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias bat='bat --theme "Catppuccin Mocha"'
alias delta='delta --syntax-theme "Catppuccin Mocha"'
alias exa='exa --icons --group-directories-first'
alias procs='procs --theme dark'
alias erd="erd -IH"

# Alias if I have this stuff installed
if [[ -f /usr/bin/bat ]]; then
    alias cat='bat'
fi

if [[ -f /usr/bin/exa ]]; then
    alias ls='exa'
    alias ll='exa -la'
fi

if [[ -f /usr/bin/nvim ]]; then
    alias vim='nvim'
fi

if [[ -f /usr/bin/dust ]]; then
    alias du="dust"
fi

if [[ -f /usr/bin/erd ]]; then
    alias tree="erd"
fi

# Options
shopt -s checkwinsize # Automatically update max lines/columns when terminal emulator is resized
shopt -s checkhash
shopt -s dirspell # Autocorrects misspelled directory names during tab completion
shopt -s cdspell
shopt -s nocaseglob
shopt -s extglob # Required for completion?
shopt -s histappend
shopt -s histreedit
shopt -s histverify
set -o noclobber # Don't clobber files with > (override with >|)
set -o ignoreeof # EOF (i.e. ctrl-d) doesn't exit the shell

# Better completions
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set mark-symlinked-directories on"

# Set completions that aren't automatically set
complete -cf doas

# Dotnet
# https://learn.microsoft.com/en-us/dotnet/core/tools/enable-tab-autocomplete

function _dotnet_bash_complete() {
    local cur="${COMP_WORDS[COMP_CWORD]}" IFS=$'\n' # On Windows you may need to use use IFS=$'\r\n'
    local candidates

    read -d '' -ra candidates < <(dotnet complete --position "${COMP_POINT}" "${COMP_LINE}" 2>/dev/null)

    read -d '' -ra COMPREPLY < <(compgen -W "${candidates[*]:-}" -- "$cur")
}

complete -f -F _dotnet_bash_complete dotnet

# Just so I don't forget:
set -o vi
# set -o emacs
