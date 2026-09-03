{ config, lib, pkgs, ... }:
{

  home.packages = with pkgs; [
    seahorse
  ];

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" ];
  };

  # make gnome keyring read a password strings from a randomly generated file in /persist that won't be backed up.
  # my thread model isn't that high, so this only prevent the keyring from being in plain text in the backup.
  systemd.user.services.gnome-keyring.Service = {
    ExecStart = lib.mkForce
      "${lib.getExe' pkgs.gnome-keyring "gnome-keyring-daemon"} --unlock --foreground --components=secrets";
    StandardInput = "file:/nix/persist/secrets/${config.home.username}/keyring-password";
  };


  home.persistence."/nix/persist/gnome_keyring" = {
    directories = [
      ".local/share/keyrings"
      ".local/share/pki"
    ];
  };
}
