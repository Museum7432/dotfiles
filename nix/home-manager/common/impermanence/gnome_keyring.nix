{ config, pkgs, ... }:
{

  home.persistence."/nix/persist/gnome_keyring" = {
    directories = [
      ".local/share/keyrings"
    ];
  };
}
