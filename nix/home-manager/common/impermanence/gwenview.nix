{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.gwenview
  ];

  home.persistence."/nix/persist/gwenview" = {
    files = [
      ".config/gwenviewrc"
    ];
  };
}
