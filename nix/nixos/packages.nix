{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zsh
    wget
    vim
    fastfetch
    htop
    git
    ncdu
    compsize
  ];
}
