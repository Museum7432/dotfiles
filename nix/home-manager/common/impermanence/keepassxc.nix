{ config, pkgs, ... }:
{
  programs.keepassxc = {
    enable = true;
    settings = {
      FdoSecrets.Enabled = true;
    };
  };

    home.persistence."/nix/persist/keepassxc" = {
      directories = [
        ".local/share/keyrings"
        ".local/share/pki"
        ".keepass"

      ];
    };
}
