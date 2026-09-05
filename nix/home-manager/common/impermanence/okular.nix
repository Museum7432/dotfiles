{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.okular
  ];

  home.persistence."/persist/okular" = {
    files = [
      ".config/okularpartrc"
      ".config/okularrc"
      ".config/okular-generator-popplerrc"
    ];
  };

}
