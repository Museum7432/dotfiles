{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gedit
    mission-center
    pavucontrol
    profile-cleaner
    vlc
  ];
}
