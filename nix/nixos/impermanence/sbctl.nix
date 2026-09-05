{ config, lib, pkgs, ... }:
{

  environment.systemPackages = [
    pkgs.sbctl
  ];

  environment.persistence."/persist/sbctl" = {
    hideMounts = true;
    directories = [
      { directory = "/var/lib/sbctl"; user = "root"; group = "root"; mode = "0700"; }
    ];
  };
}
