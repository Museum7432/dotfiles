{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    zed-editor
  ];

  home.persistence."/nix/persist/zed" = {
    directories = [
      ".config/zed"
      ".local/share/zed"
    ];
  };
}
