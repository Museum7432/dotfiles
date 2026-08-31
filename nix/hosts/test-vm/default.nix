{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware.nix
    ./disko.nix
    # ./boot.nix
    (import ../common/limits.nix { username = "arch"; })
    ../common/only_hibernation.nix
  ];

  system.stateVersion = "26.05";
  # generic hostname
  networking.hostName = "test";

  time.timeZone = "Asia/Bangkok";


  networking.networkmanager.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

}
