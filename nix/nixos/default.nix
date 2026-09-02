{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./impermanence
    ./sway.nix
    ./packages.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
  };

  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
    };
    # Opinionated: disable channels
    channel.enable = false;
  };


  security.polkit.enable = true;
  networking.networkmanager.enable = true;

  # enable bluetooth, will be configurable per host if I ever have a desktop
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
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
        chooser_cmd = "${pkgs.wofi}/bin/wofi --show=dmenu";
        # output_name, max_fps, exec_before, exec_after
      };

    };
    config.sway = {
      default = lib.mkDefault [ "wlr" "gtk" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
      "org.freedesktop.impl.portal.AppChooser" = [ "kde" ];
    };
  };




  # sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };


  # dolphin fix
  environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";


}
