{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  gruvboxTheme = pkgs.gruvbox-gtk-theme.override {
    colorVariants = [ "dark" ];
    themeVariants = [ "default" ];
    tweakVariants = [ "medium" ];
  };
in
{
  programs.niri = {
    enable = true;
    settings = {
      environment = {
        CLUTTER_BACKEND = "wayland";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
        # WLR_RENDERER = "vulkan";
        WLR_NO_HARDWARE_CURSORS = "1";
        QT_QPA_PLATFORMTHEME = "qt6ct";
        GTK_IM_MODULE = "simple";
      };
      input = {
        keyboard = {
          xkb = {
            layout = "br";
            variant = "abnt2";
            options = "srvrkeys:none";
          };
          repeat-delay = 270; # Tempo até começar a repetir (ms)
          repeat-rate = 50; # Repetições por segundo
        };
        mouse = {
          accel-profile = "flat"; # Desativa aceleração
          accel-speed = -0.1; # Velocidade mais lenta (-1.0 a 1.0)
        };
      };
      spawn-at-startup = [
        {
          command = [ "xwayland-satellite" ];
        }
        {
          command = [
            "qs"
            "-c"
            "noctalia-shell"
            "ipc"
            "call"
            "wallpaper"
            "set"
            "/home/mingas/gruvbox-dark-rainbow.png"
            "HDMI-A-1"
          ];
        }

      ];
      outputs = {
        "HDMI-A-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 100.0;
          };
        };
      };
      # Styling configuration
      overview = {
        workspace-shadow.enable = false;
        backdrop-color = "transparent";
      };
      cursor = {
        size = 30;
        theme = "everforest-cursors";
      };
      layout = {
        background-color = "transparent";
        focus-ring.enable = false;
        border = {
          active.color = "#d79921";
          inactive.color = "#504945";
          enable = true;
          width = 2;
        };
        shadow = {
          enable = false;
        };
        preset-column-widths = [
          { proportion = 0.25; }
          { proportion = 0.5; }
          { proportion = 0.75; }
          { proportion = 1.0; }
        ];
        default-column-width = {
          proportion = 0.5;
        };
        always-center-single-column = true;
        gaps = 6;
        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };
        tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          position = "left";
          corner-radius = 20.0;
          gap = -12.0;
          gaps-between-tabs = 10.0;
          width = 4.0;
          length.total-proportion = 0.1;
        };
      };

      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;

      layer-rules = [
        {
          matches = [ { namespace = "^noctalia-wallpaper*"; } ];
          place-within-backdrop = true;
        }
      ];
    };

  };

  imports = [
    ./rules.nix
    ./binds.nix
    ./noctalia.nix
  ];

  # Deixa o GTK3 usando adw-gtk3 de forma declarativa (evita precisar do nwg-look)
  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark-Medium";
      package = gruvboxTheme;
    };
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Gruvbox-Dark-Medium";
    };
  };

  # Link do tema para pasta local, permitindo que Flatpaks e apps GTK4 o encontrem via filesystem
  home.file.".local/share/themes/Gruvbox-Dark-Medium".source =
    "${gruvboxTheme}/share/themes/Gruvbox-Dark-Medium";
  home.sessionVariables = {
    GTK_THEME = "Gruvbox-Dark-Medium";
    XDG_DATA_DIRS = "${gruvboxTheme}/share:$XDG_DATA_DIRS";
    XDG_ICON_DIR = "${pkgs.gruvbox-plus-icons}/share/icons/Gruvbox-Plus-Dark";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
  };

  home.pointerCursor = {
    package = pkgs.everforest-cursors;
    name = "everforest-cursors";
    size = 30;
    gtk.enable = true;
    x11.enable = true;
  };

  home.packages = with pkgs; [
    nautilus
    xwayland-satellite
    adw-gtk3
    qt6Packages.qt6ct
    nwg-look
    matugen
  ];
}
