{ config, pkgs, ... }:
{
  home.persistence."/persist/flatpak" = {
    directories = [
      # the bins
      ".local/share/flatpak"
      # where flatpak download the app during install, stored in /persist/cache instead
      # ".cache/flatpak"
      # app datas
      ".var/app"
    ];
  };
}
