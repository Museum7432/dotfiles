{
  users.mutableUsers = false;

  users.users = {
    arch = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = ["arch" "wheel" "networkmanager" "video" "audio" "input" "kvm"];
      initialPassword = "test";
      # will change latter
      # hashedPasswordFile = "/nix/persist/passwords/arch";
    };
  };

  users.groups.arch.gid = 1000;
}
