{ pkgs, ... }:
let
  gtkTheme = pkgs.callPackage ./gruvbox-gtk-theme/package.nix {
    colorVariants = [ "light" ];
    themeVariants = [ "green" ];
    tweakVariants = [ "medium" ];
  };
in
{
  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Green-Light-Medium";
      package = gtkTheme;
    };
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = (
        pkgs.gruvbox-plus-icons.override {
          folder-color = "citron";
        }
      );
    };
    gtk3.extraConfig = {
      gtk-application-prefer-light-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-light-theme = 1;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-light";
      gtk-theme = "Gruvbox-Green-Light-Medium";
    };
  };

  # Link do tema para pasta local, permitindo que Flatpaks e apps GTK4 o encontrem via filesystem
  home.file.".local/share/themes/Gruvbox-Green-Light-Medium".source =
    "${gtkTheme}/share/themes/Gruvbox-Green-Light-Medium";
  home.sessionVariables = {
    GTK_THEME = "Gruvbox-Green-Light-Medium";
    XDG_DATA_DIRS = "${gtkTheme}/share:$XDG_DATA_DIRS";
    XDG_ICON_DIR = "${pkgs.gruvbox-plus-icons}/share/icons/Gruvbox-Plus-Dark";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
  };

  # home.file.".config/gtk-3.0/gtk.css".text = ''
  #   /* Increase padding/margins globally where it makes sense */
  #   button, entry, label, menuitem, treeview, notebook tab {
  #     padding: 8px 12px;   /* Adjust vertical/horizontal as needed; default is often smaller */
  #     margin: 4px;
  #   }

  #   /* More space in titlebars/headerbars (common complaint) */
  #   headerbar {
  #     padding: 6px 12px;
  #     min-height: 48px;    /* Optional: taller bar for more space */
  #   }

  #   headerbar button, headerbar entry {
  #     margin: 4px;
  #     padding: 6px 10px;
  #   }

  #   /* Menus and popovers */
  #   menu, popover {
  #     padding: 6px;
  #   }

  #   menuitem {
  #     padding: 8px 12px;
  #   }

  #   /* List/tree views (e.g., file managers, settings) */
  #   row, cell {
  #     padding: 6px;
  #   }

  #   /* Text entries and search bars */
  #   entry {
  #     padding: 8px 12px;
  #   }

  #   /* Adjust font rendering spacing if needed (rarely the core issue) */
  #   * {
  #     -GtkWidget-text-handle-width: 20px;  /* Example for text handles */
  #   }
  # '';

  # home.file.".config/gtk-4.0/gtk.css".text = ''
  #   /* Same or similar rules for GTK4/libadwaita apps */
  #   /* Copy the above CSS here; GTK4 supports most of the same properties */
  #   button, entry, label {
  #     padding: 10px 14px;
  #     margin: 6px;
  #   }

  #   headerbar {
  #     padding: 8px 14px;
  #   }

  #   /* Add more as needed */
  # '';

  home.pointerCursor = {
    package = pkgs.everforest-cursors;
    name = "everforest-cursors";
    size = 30;
    gtk.enable = true;
    x11.enable = true;
  };
}
