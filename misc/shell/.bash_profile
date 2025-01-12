#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR=/usr/bin/vim

if [ "$(tty)" = "/dev/tty1" ] || [ "$(tty)" = "/dev/ttyv0" ] ; then
	export __EGL_VENDOR_LIBRARY_FILENAMES="/usr/share/glvnd/egl_vendor.d/50_mesa.json"
	export __GLX_VENDOR_LIBRARY_NAME="mesa"
	#export LIBVA_DRIVER_NAME=radeonsi
	#export VDPAU_DRIVER=radeonsi

	export XDG_SESSION_TYPE=wayland
	export XDG_SESSION_DESKTOP=sway
	#export GTK_USE_PORTAL=1
	export GDK_DEBUG=portals
	# firefox
	export BROWSER=firefox
	export MOZ_ENABLE_WAYLAND=1

	# qt wayland
	export QT_QPA_PLATFORM="wayland;xcb"
	export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
	#export QT_WAYLAND_FORCE_DPI=physical
	
	export ELECTRON_OZONE_PLATFORM_HINT=wayland

	#Java XWayland blank screens fix
	export _JAVA_AWT_WM_NONREPARENTING=1

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
	/usr/bin/kbuildsycoca6

	export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

	# theme
	#export GTK_THEME=Breeze
	export QT_QPA_PLATFORMTHEME=qt6ct

	export WLR_NO_HARDWARE_CURSORS=1

	#export WLR_RENDERER=vulkan
	export XDG_CURRENT_DESKTOP=sway

    	exec sway --unsupported-gpu > ~/.sway.log 2>&1
fi