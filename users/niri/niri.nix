{ pkgs, ... }:
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
        WLR_RENDERER = "vulkan";
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
          command = [ "${pkgs.xdg-desktop-portal-gnome}/libexec/xdg-desktop-portal-gnome" ];
        }
      ];
      outputs = {
        "HDMI-A-1" = {
          variable-refresh-rate = false;
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
      layout = {
        background-color = "transparent";
        focus-ring.enable = false;
        border = {
          active.color = "#c6c929ff";
          inactive.color = "#7a7a15ff";
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
}
