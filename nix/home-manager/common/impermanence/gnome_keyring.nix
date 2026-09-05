{ config, lib, pkgs, ... }:
{

  home.packages = with pkgs; [
    seahorse
    gcr
  ];

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" ];
  };

  # make gnome keyring read a password strings from a randomly generated file in /persist that won't be backed up.
  # my threat model isn't that high, so this only prevent the keyring from being in plain text in the backup.
  systemd.user.services.gnome-keyring.Service = {
    ExecStart = lib.mkForce
      "${lib.getExe' pkgs.gnome-keyring "gnome-keyring-daemon"} --unlock --foreground --components=secrets";
    StandardInput = "file:/persist/secrets/${config.home.username}/keyring-password";
  };

  # # ssh agent
  # services.gnome.gcr-ssh-agent.enable = true;
  # systemd.user.services.gcr-ssh-agent.Unit.WantedBy = [ "graphical-session.target" ];
  home.sessionVariables.SSH_AUTH_SOCK = "\${XDG_RUNTIME_DIR}/gcr/ssh";


  home.persistence."/persist/gnome_keyring" = {
    directories = [
      ".local/share/keyrings"
      ".local/share/pki"
    ];
  };
}
