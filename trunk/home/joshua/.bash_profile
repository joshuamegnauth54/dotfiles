# Environmental variables
# Add Cargo and local, non-root NPM to PATH
export NPM_PACKAGES="${HOME}/.cache/npm/npm-packages"
export PATH="$PATH:${HOME}/.cargo/bin:${NPM_PACKAGES}/bin"
export MANPATH="${MANPATH-$(manpath)}:${NPM_PACKAGES}/share/man"
export GOPATH="${HOME}/.cache/.go:${HOME}/Repos/Golang"

# Editors, pager, et cetera
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less" # I think nvimpager doesn't work with ANSI escape sequences for colors
export BROWSER="firefox"

# Rustlang
export RUST_BACKTRACE=1
export CARGO_NAME=Joshua

# SDL
export SDL_AUDIODRIVER="pipewire"
export SDL_VIDEODRIVER="wayland"

# Java
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -swing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# wlroots
export WLR_RENDERER=vulkan

# Program specific
# export PYCHARM_JDK=`java-config -O`
export KITTY_ENABLE_WAYLAND=1
export MOZ_ENABLE_WAYLAND=1

# double entries in the shell history
export HISTCONTROL="erasedups:ignoreboth"

# Trim long paths
export PROMPT_DIRTRIM=2

# Qt environmental variables
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_QPA_PLATFORMTHEME=gnome
export QT_QPA_PLATFORM=wayland

# Clutter
export CLUTTER_BACKEND=wayland

# SciPy
export SCIPY_PIL_IMAGE_VIEWER=nomacs
export USE_SYMENGINE=1

# Don't append CWD to the import path
export PYTHONSAFEPATH

# Execute .bashrc last
[[ -f ~/.bashrc ]] && . ~/.bashrc
