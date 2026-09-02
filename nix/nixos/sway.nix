{ config, lib, pkgs, ... }:

let
  sway-run = pkgs.writeShellScriptBin "sway-run" ''
    export EDITOR=vim

    # Session
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=sway
    export XDG_CURRENT_DESKTOP=sway

    # Wayland stuff
    export QT_QPA_PLATFORM=wayland
    export SDL_VIDEODRIVER=wayland,x11
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


    eval $(ssh-agent) > /dev/null
    #export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh
    #export GNOME_KEYRING_CONTROL=$XDG_RUNTIME_DIR/keyring

    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULES="wayland;fcitx;ibus"
    export XMODIFIERS=@im=fcitx
    #export SDL_IM_MODULE=fcitx
    export GLFW_IM_MODULE=fcitx
    export INPUT_METHOD=fcitx
    export IMSETTINGS_MODULE=fcitx

    export XDG_MENU_PREFIX=arch-
    #export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

    export QT_QPA_PLATFORMTHEME=qt6ct
    #export QT_QPA_PLATFORMTHEME=qt5ct:qt6ct

    # export WLR_NO_HARDWARE_CURSORS=1
    # export XCURSOR_THEME="Windows-10"
    # export XCURSOR_SIZE="24"

    # export GTK_THEME="Breeze:dark"

    export XDG_CURRENT_DESKTOP=sway

    # if [ -e /dev/dri/renderD128 ] && ${pkgs.vulkan-tools}/bin/vulkaninfo --summary >/dev/null 2>&1; then
    #   # export WLR_RENDERER=vulkan

    #   # needed for running rocm on 780m APU
    #   # export HSA_OVERRIDE_GFX_VERSION=11.0.1
    #   # export LLVM_PATH=/opt/rocm/llvm

    #   # export VDPAU_DRIVER=radeonsi

    # fi


    exec systemd-cat --identifier=sway sway "$@"
  '';
in
{
  services.gnome.gnome-keyring.enable = true;
  services.blueman.enable = true;


  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };



  environment.systemPackages = with pkgs; [
    sway-run
    foot
    gtklock
    wl-clipboard
    grim
    slurp

    swayidle
    swaybg
    swayr
    alacritty
    waybar
    j4-dmenu-desktop
    bemenu
    wofi

    brightnessctl

    wl-mirror

  ];

  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only   # ttf-nerd-fonts-symbols
    nerd-fonts.noto           # ttf-noto-nerd
    roboto-mono               # ttf-roboto-mono
    nerd-fonts.roboto-mono    # ttf-roboto-mono-nerd
  ];



  services.greetd = {
      enable = true;

      settings = {
        default_session = {
          command = "${pkgs.greetd.greetd}/bin/agreety --cmd sway-run";
          user = "greeter";
        };

        initial_session = {
          command = "sway-run";
          user = "arch";    # replace "arch" with your actual NixOS user
        };
      };
    };

}
