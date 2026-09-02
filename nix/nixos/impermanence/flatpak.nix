{ config, lib, pkgs, ... }:
{
  services.flatpak.enable = true;

  environment.persistence."/nix/persist/flatpak_system" = {
    hideMounts = true;
    directories = [
      "/var/lib/flatpak"
    ];
  };
}
