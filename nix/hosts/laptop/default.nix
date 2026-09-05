{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware.nix
    ./disko.nix
    ./boot.nix


    (import ../common/limits.nix { username = "arch"; })
    ../common/only_hibernation.nix
  ];

  system.stateVersion = "26.05";
  # generic hostname
  networking.hostName = "DESKTOP-E4VGZPX";

  time.timeZone = "Asia/Bangkok";

  boot.kernelParams = [ "cfg80211.ieee80211_regdom=VN" ];

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # amdgpu
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.amdgpu.initrd.enable = true;
  hardware.amdgpu.opencl.enable = true;

  # we don't need this on a laptop
  systemd.services.NetworkManager-wait-online.enable = false;
}
