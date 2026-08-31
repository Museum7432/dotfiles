{ config, pkgs, ... }:
{
  imports = [
    ./packages.nix
    ../common/sway.nix
    ../common/zsh.nix
    ../common/theme.nix
  ];

  home.username = "arch";
  home.homeDirectory = "/home/arch";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;


}
