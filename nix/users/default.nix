{
  users.users = {
    arch = {
      initialPassword = "test";
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "video" "audio" "input" "kvm"];
    };
  };

}
