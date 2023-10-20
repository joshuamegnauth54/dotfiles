# Environmental variables
# Add Cargo and local, non-root NPM to PATH
export NPM_PACKAGES="${HOME}/.cache/npm/npm-packages"
export PATH="$PATH:${HOME}/.cargo/bin:${NPM_PACKAGES}/bin:${HOME}/.dotnet/tools"
export MANPATH="${MANPATH-$(manpath)}:${NPM_PACKAGES}/share/man"
export GOPATH="${HOME}/Repos/Golang"
export GOMODCACHE="${HOME}/.cache/go"
export DOTNET_ROOT="/opt/dotnet"

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
# Prefer Wayland but allow x11 for broken programs
export SDL_VIDEODRIVER="wayland,x11"

# Java
# Fix GUI
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

# wlroots
export WLR_RENDERER=vulkan

# Program specific
# export PYCHARM_JDK=`java-config -O`
export KITTY_ENABLE_WAYLAND=1
export MOZ_ENABLE_WAYLAND=1
export XDG_SESSION_TYPE=wayland

# double entries in the shell history
export HISTCONTROL="erasedups:ignoreboth"

# Trim long paths
export PROMPT_DIRTRIM=2

# Qt environmental variables
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_QPA_PLATFORMTHEME="wayland;xcb"
export QT_QPA_PLATFORM=wayland

# Clutter
export CLUTTER_BACKEND=wayland

# SciPy
export SCIPY_PIL_IMAGE_VIEWER=nsxiv
export USE_SYMENGINE=1

# Don't append CWD to the import path
export PYTHONSAFEPATH

# Use system libraries for Android emulator
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1

# Disable C# telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Execute .bashrc last
[[ -f ~/.bashrc ]] && . ~/.bashrc
