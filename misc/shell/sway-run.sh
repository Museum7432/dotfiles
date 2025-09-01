#!/bin/sh
# Session
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway

# Wayland stuff
export QT_QPA_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export GDK_DEBUG=portals
#export GTK_USE_PORTAL=1
# firefox
export BROWSER=firefox
export MOZ_ENABLE_WAYLAND=1

# qt wayland
export QT_QPA_PLATFORM="wayland;xcb"
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
#export QT_WAYLAND_FORCE_DPI=physical

export ELECTRON_OZONE_PLATFORM_HINT=wayland


export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh
export GNOME_KEYRING_CONTROL=$XDG_RUNTIME_DIR/keyring

export GTK_IM_MODULE=fcitx
export QT_IM_MODULES="wayland;fcitx;ibus"
export XMODIFIERS=@im=fcitx
#export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=fcitx
export INPUT_METHOD=fcitx
export IMSETTINGS_MODULE=fcitx

export XDG_MENU_PREFIX=plasma-
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

export QT_QPA_PLATFORMTHEME=qt6ct

# export WLR_NO_HARDWARE_CURSORS=1

#export WLR_RENDERER=vulkan
export XDG_CURRENT_DESKTOP=sway
# exec sway "$@"

#
# If you use systemd and want sway output to go to the journal, use this
# instead of the `exec sway "$@"` above:
#
exec systemd-cat --identifier=sway sway "$@"
#
