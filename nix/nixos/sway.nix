{ config, lib, pkgs, ... }:

let
  sway-run = pkgs.writeShellScriptBin "sway-run" ''
    export EDITOR=vim

    # Session
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=sway
    export XDG_CURRENT_DESKTOP=sway

    # Wayland stuff
    # export QT_QPA_PLATFORM=wayland
    # export SDL_VIDEODRIVER=wayland,x11
    # export _JAVA_AWT_WM_NONREPARENTING=1
    # export GDK_DEBUG=portals

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

    rofi

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



  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];

    wlr.settings = {
      screencast = {
        chooser_type = "dmenu";
        # TODO: perhaps we should let wofi cache what we select here so that it rememeber the option next time
        # chooser_cmd = "${pkgs.wofi}/bin/wofi -d -k /dev/null --no-actions -i -G";
        chooser_cmd = "${pkgs.rofi}/bin/rofi -dmenu -theme android_notification";
        # output_name, max_fps, exec_before, exec_after
      };

    };
    config.sway = {
      default = lib.mkDefault [ "wlr" "gtk" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
      "org.freedesktop.impl.portal.AppChooser" = [ "kde" ];
    };
  };


}
