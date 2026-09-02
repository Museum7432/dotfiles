{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.dolphin
    kdePackages.qtsvg
  ];

  programs.plasma.enable = true;

  programs.plasma.configFile."dolphinrc" = {
    "ContentDisplay"."UsePermissionsFormat" = "CombinedFormat";

    "DetailsMode"."ExpandableFolders" = false;

    "General"."FilterBar" = true;
    "General"."OpenExternallyCalledFolderInNewTab" = true;
    "General"."ShowFullPathInTitlebar" = true;

    "InformationPanel"."dateFormat" = "ShortFormat";

    "KFileDialog Settings"."Places Icons Auto-resize" = false;
    "KFileDialog Settings"."Places Icons Static Size" = 22;

    "MainWindow"."MenuBar" = "Disabled";

    "PreviewSettings"."Plugins" = "appimagethumbnail,audiothumbnail,glycin-heif,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,directorythumbnail,fontthumbnail,pothumbnail,heif,imagethumbnail,glycin-image-rs,jpegthumbnail,glycin-jxl,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mobithumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,glycin-svg,svgthumbnail,ffmpegthumbs";
  };

  home.persistence."/nix/persist/dolphin" = {
    directories = [
      ".config/session"
    ];
    files = [
      ".local/state/dolphinstaterc"
      ".local/share/user-places.xbel"
      ".local/share/user-places.xbel.bak"
      ".local/share/user-places.xbel.tbcache"
    ];
  };
}
