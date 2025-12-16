{
  pkgs,
  inputs,
  ...
}:
{
  programs.niri = {
    enable = true;
    settings = {
      input = {
        keyboard = {
          xkb = {
            layout = "br";
            variant = "abnt2";
            options = "srvrkeys:none";
          };
        };
      };
      spawn-at-startup = [
        {
          command = [ "noctalia-shell" ];
        }
        {
          command = [ "xwayland-satellite" ];
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
        size = 20;
      };

      layout = {
        background-color = "transparent";
        focus-ring.enable = false;
        border = {
          enable = true;
          width = 2;
          active.color = "#0d5ba5";
          inactive.color = "#204c78";
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

  home.packages = with pkgs; [
    xwayland-satellite
  ];
}
