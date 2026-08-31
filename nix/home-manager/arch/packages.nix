{ pkgs, ... }:
{
  home.packages = with pkgs; [
    firefox
    fastfetch
    gedit
  ];
}
