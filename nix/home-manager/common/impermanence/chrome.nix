{ config, pkgs, ... }:
{

  # home.packages = with pkgs; [
  #   google-chrome
  # ];
  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
    commandLineArgs = [
      "--enable-logging=stderr"
      "--ignore-gpu-blocklist"
    ];
  };


  home.persistence."/nix/persist/firefox" = {
    directories = [
      ".config/google-chrome"
    ];
  };
}
