{ config, pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
    commandLineArgs = [
    ];
  };


  home.persistence."/persist/google-chrome" = {
    directories = [
      ".config/google-chrome"
    ];
  };
}
