{ pkgs, config, ... }:
let
  gtkTheme = pkgs.kanagawa-gtk-theme;
  themeName = "Gruvbox-Light";
  iconName = "Gruvbox-Plus-Dark";
  cursorName = "everforest-cursors-light";
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
      package = pkgs.gruvbox-plus-icons.override {
        folder-color = "citron";
      };
    };

    # Configurações extras GTK3
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-light-theme = 0;
      };
      # CSS customizado para GTK3 (opcional)
      extraCss = '''';
    };

    # Configurações extras GTK4
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-light-theme = 0;
      };
      # CSS customizado para GTK4 (opcional)
      extraCss = '''';
    };
  };

  # Cursor unificado
  home.pointerCursor = {
    package = pkgs.everforest-cursors;
    name = cursorName;
    size = 30;
    gtk.enable = true;
    x11.enable = true;
  };

  # dconf/GSettings - CRÍTICO para consistência
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-light";
      gtk-theme = themeName;
      icon-theme = iconName;
      cursor-theme = cursorName;
      cursor-size = 30;
    };
  };

  # Symlinks para garantir que apps encontrem o tema
  home.file = {
    # Tema em ~/.local/share/themes para apps e Flatpaks
    ".local/share/themes/${themeName}".source = "${gtkTheme}/share/themes/${themeName}";

    # === CRÍTICO PARA GTK4/libadwaita ===
    # Symlink dos assets gtk-4.0 para o diretório de config
    ".config/gtk-4.0/gtk.css" = {
      source = "${gtkTheme}/share/themes/${themeName}/gtk-4.0/gtk.css";
      force = true;
    };
    ".config/gtk-4.0/gtk-dark.css" = {
      source = "${gtkTheme}/share/themes/${themeName}/gtk-4.0/gtk-dark.css";
      force = true;
    };

    # Assets do tema GTK4 (se existirem)
    ".config/gtk-4.0/assets" = {
      source = "${gtkTheme}/share/themes/${themeName}/gtk-4.0/assets";
      recursive = true;
      force = true;
    };
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

    systemDirs.data = [
      "${gtkTheme}/share"
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    ];
  };
}
