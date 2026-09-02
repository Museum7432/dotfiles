# kde programs configs for use under sway
{pkgs, ...}:
{

  # qt
  home.packages = [
    pkgs.kdePackages.breeze
    pkgs.kdePackages.breeze.qt5
    pkgs.kdePackages.breeze-icons
    pkgs.kdePackages.breeze-gtk
  ];

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "breeze";

    qt5ctSettings = {
      Appearance = {
        custom_palette = false;
        icon_theme = "breeze";
        standard_dialogs = "xdgdesktopportal";
        style = "Breeze";
      };
      Fonts = {
        fixed = "Roboto Mono [GOOG],11,-1,5,50,0,0,0,0,0,Regular";
        general = "NotoSans Nerd Font,11,-1,5,50,0,0,0,0,0,Regular";
      };
      Interface = {
        activate_item_on_single_click = 1;
        buttonbox_layout = 0;
        cursor_flash_time = 1000;
        dialog_buttons_have_icons = 1;
        double_click_interval = 400;
        keyboard_scheme = 2;
        menus_have_icons = true;
        show_shortcuts_in_context_menus = true;
        toolbutton_style = 4;
        underline_shortcut = 1;
        wheel_scroll_lines = 3;
      };
      Troubleshooting = {
        force_raster_widgets = 1;
        ignored_applications = "@Invalid()";
      };
    };
  };

  gtk = {
    enable = true;

    theme = {
      name = "Breeze";
      package = pkgs.kdePackages.breeze-gtk;
    };

    iconTheme = {
      name = "breeze-dark";
      package = pkgs.kdePackages.breeze-icons;
    };

    cursorTheme = {
      name = "Breeze_Light";
      package = pkgs.kdePackages.breeze;
      size = 24;
    };

    font = {
      name = "NotoSans Nerd Font";
      size = 11;
    };
  };

  # the cursor in sway is actually set in the sway config
  # home.pointerCursor = {
  #   package = pkgs.kdePackages.breeze;
  #   name = "Breeze_Light";
  #   size = 24;
  #   gtk.enable = true;
  #   x11.enable = true;
  # };

}
