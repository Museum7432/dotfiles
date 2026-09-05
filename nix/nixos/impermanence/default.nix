{...}:
{
  imports = [
    ./warp_vpn.nix
    ./flatpak.nix
    ./sbctl.nix
  ];

  # the basics for booting
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"

      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"

      "/etc/NetworkManager/system-connections"
      "/var/lib/NetworkManager"

      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }

      # battery history
      "/var/lib/upower"
    ];
    files = [
      "/etc/machine-id"
      # { file = "/etc/nix/id_rsa"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
  };

  # no sudo lecture
  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';
}
