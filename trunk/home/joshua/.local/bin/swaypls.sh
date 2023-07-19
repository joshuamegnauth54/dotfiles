#/bin/sh

# Stupid Nvidia
export WLR_NO_HARDWARE_CURSORS=1

# Open links in Firefox
export MOZ_DBUS_REMOTE=1

sway --unsupported-gpu
