{config, lib, pkgs, ...}:
{


  users.mutableUsers = false;

  users.users = {
    arch = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = ["arch" "wheel" "networkmanager" "video" "audio" "input" "kvm"];
      # initialPassword = "test";
      # will change latter
      # hashedPasswordFile = "/nix/persist/passwords/arch";
    };
  };

  users.groups.arch.gid = 1000;
  imports = [
    # TODO: add support for multi user latter, this somehow break the build process
    # (import ./bootstrap_secrets.nix { user = "arch";  user_id = "1000";})
    ./bootstrap_secrets.nix
  ];
}
