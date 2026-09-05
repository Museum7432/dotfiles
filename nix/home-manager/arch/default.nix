{ config, pkgs, ... }:
{
  imports = [
    ./packages.nix
    ../common/sway.nix
    ../common/shell.nix
    ../common/theme.nix
    ../common/impermanence
    ../common/use_wayland.nix
  ];

  home.username = "arch";
  home.homeDirectory = "/home/arch";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  # stop warp cli from asking for tos
  home.file.".local/share/warp/accepted-tos.txt".text = "yes";

  # default browser
  home.sessionVariables.BROWSER = "firefox";


}
