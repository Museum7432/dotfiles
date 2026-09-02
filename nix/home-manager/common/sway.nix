{ config, pkgs, ... }:
{
  imports = [
    # ./polkit-gnome.nix
  ];

  home.packages = with pkgs; [
    playerctl
    wofi
  ];

  # SWAY
  # copy only the module
  xdg.configFile = {
    "sway/bindings" = { source = ../../../sway/bindings; recursive = true; };
    "sway/ui"       = { source = ../../../sway/ui;       recursive = true; };
  };

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config = null;
    wrapperFeatures.gtk = true;

    extraConfig = ''
      include /etc/sway/config.d/*

      seat seat0 xcursor_theme Breeze_Light 24

      include ${config.xdg.configHome}/sway/bindings/basic
      include ${config.xdg.configHome}/sway/ui/application_defaults
    '';
  };


  # WAYBAR
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };


  xdg.configFile."waybar" = {
    source = ../../../waybar;
    recursive = true;
    force = true;
  };

  # ALACRITTY
  xdg.configFile."alacritty" = {
    source = ../../../alacritty;
    recursive = true;
  };

  # SWAYNC
  services.swaync = {
    enable = true;
  };

  xdg.configFile."swaync" = {
    source = ../../../swaync;
    recursive = true;
    force = true;
  };

  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;

  # SWAYR
  programs.swayr = {
    enable = true;
    systemd.enable = true;
    settings = {misc.seq_inhibit = false;};
  };


  # we still need wl-clip-persist to retain the last paste when the app is closed
  services.wl-clip-persist = {
    enable = true;
    clipboardType = "regular";
    systemdTargets = [ "graphical-session.target" ];
  };

  services.cliphist = {
    enable = true;
    systemdTargets = [ "graphical-session.target" ];

    extraOptions = [
      "-max-dedupe-search" "10"
      "-max-items" "500"
    ];

    allowImages = true;
  };

  services.swayidle = {
    enable = true;

    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.brightnessctl}/bin/brightnessctl -s && ${pkgs.brightnessctl}/bin/brightnessctl s 1%";
        resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r";
      }
      {
        timeout = 1770;
        command = "${pkgs.libnotify}/bin/notify-send 'hibernating in 30 seconds' -t 29000";
      }
      {
        timeout = 1800;
        command = "${pkgs.systemd}/bin/systemctl hibernate";
      }
    ];

    events = {
      "before-sleep" = "${pkgs.playerctl}/bin/playerctl pause";
    };
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "polkit-gnome-authentication-agent-1";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };


}
