{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.okular
  ];

  home.persistence."/nix/persist/okular" = {
    files = [
      ".config/okularpartrc"
      ".config/okularrc"
      ".config/okular-generator-popplerrc"
    ];
  };

}
