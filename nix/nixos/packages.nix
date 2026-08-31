{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zsh
    wget
    vim
  ];
}
