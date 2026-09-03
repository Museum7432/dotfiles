{...}:{
  imports = [
    ./firefox.nix
    ./dolphin.nix
    ./okular.nix
    ./gwenview.nix
    ./zed.nix
    ./gnome_keyring.nix
    # ./keepassxc.nix
    ./flatpak.nix
    ./chrome.nix
  ];

  # put these dirs on a different paths for isolation
  home.persistence."/nix/persist/data" = {
    directories = [
      "Documents"
      "Downloads"
      "Games"
      "Music"
      "Others"
      "Pictures"
      "Projects"
      "Videos"

      ".ssh"
      ".gnupg"
    ];
  };

  # store the caching
  home.persistence."/nix/persist/cache" = {
    directories = [
      ".cache/mesa_shader_cache"
      ".cache/mozilla"
      ".cache/flatpak"
      ".cache/google-chrome"
    ];
  };

}
