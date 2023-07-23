#!/bin/sh

# Stupid Nvidia
export WLR_NO_HARDWARE_CURSORS=1

# Open links in Firefox
export MOZ_DBUS_REMOTE=1

# Misc other Nvidia junk
export MOZ_ENABLE_WAYLAND=1
export MOZ_USE_XINPUT2=1
export XWAYLAND_NO_GLAMOR=1
export GBM_BACKEND=nvidia-drm
export __GL_GSYNC_ALLOWED=0
export __GL_VRR_ALLOWED=0
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export QT_QPA_PLATFORMTHEME=wayland

sway --unsupported-gpu -D noscanout
