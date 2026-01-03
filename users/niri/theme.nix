{ pkgs, config, ... }:
let
  gtkTheme = pkgs.adw-gtk3;
  themeName = "Adwaita-dark";
  iconName = "Arashi";
  cursorName = "graphite-dark";
in
{
  gtk = {
    enable = true;

    theme = {
      name = themeName;
      package = gtkTheme;
    };

    iconTheme = {
      name = iconName;
      package = pkgs.arashi;
    };

    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      # extraCss = '''';
    };

    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      # extraCss = '''';
    };
  };

  home.pointerCursor = {
    package = pkgs.graphite-cursors;
    name = cursorName;
    size = 25;
    gtk.enable = true;
    x11.enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = themeName;
      icon-theme = iconName;
      cursor-theme = cursorName;
      cursor-size = 25;
    };
  };

  home.file = {
    ".local/share/themes/${themeName}".source = "${gtkTheme}/share/themes/${themeName}";
  };

  home.sessionVariables = {
    GTK_THEME = themeName;
  };

  home.packages = with pkgs; [
    gtkTheme
    gnome-themes-extra
    gtk3
    gtk4
    gsettings-desktop-schemas
  ];

  xdg = {
    enable = true;

    configFile."gtk-3.0/gtk.css".enable = false;
    configFile."gtk-4.0/gtk.css".enable = false;

    systemDirs.data = [
      "${gtkTheme}/share"
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    ];
  };
}
