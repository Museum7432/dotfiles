{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    firefox
  ];

  home.persistence."/nix/persist/firefox" = {
    directories = [
      ".config/mozilla"
    ];
  };
}
