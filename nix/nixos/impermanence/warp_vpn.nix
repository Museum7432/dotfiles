{ config, lib, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.cloudflare-warp
  ];

  services.cloudflare-warp = {
    enable = true;
    openFirewall = true;
  };


  environment.persistence."/nix/persist/warp_vpn" = {
    hideMounts = true;
    directories = [
      "/var/lib/cloudflare-warp"
    ];
  };
  # warp-cli will check if the ~/.local/share/warp/accepted-tos.txt file exist
  # we will hardfix it in the home manager
}
