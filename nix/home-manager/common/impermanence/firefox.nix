{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    firefox
  ];

  home.persistence."/persist/firefox" = {
    directories = [
      ".config/mozilla"
    ];
  };
}
