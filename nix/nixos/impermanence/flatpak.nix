{ config, lib, pkgs, ... }:
{
  services.flatpak.enable = true;

  environment.persistence."/persist/flatpak_system" = {
    hideMounts = true;
    directories = [
      "/var/lib/flatpak"
    ];
  };
}
