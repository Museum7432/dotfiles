{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.gwenview
  ];

  home.persistence."/persist/gwenview" = {
    files = [
      ".config/gwenviewrc"
    ];
  };
}
