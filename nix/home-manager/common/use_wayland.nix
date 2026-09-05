{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    xeyes
  ];
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION="1";
  };
}
