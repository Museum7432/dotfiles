{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware.nix
    ../common/only_hibernation.nix
    (import ../common/limits.nix { username = "arch"; })

    # ./disko.nix
    # ./boot.nix
  ];

  system.stateVersion = "26.05";
  # generic hostname
  networking.hostName = "DESKTOP-E4VGZPX";

  time.timeZone = "Asia/Bangkok";




  boot.kernelParams = [ "cfg80211.ieee80211_regdom=VN" ];
}
