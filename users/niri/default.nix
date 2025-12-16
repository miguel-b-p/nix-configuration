{
  pkgs,
  inputs,
  ...
}:
let
  windowRules = [
    {
      geometry-corner-radius =
        let
          radius = 12.0;
        in
        {
          bottom-left = radius;
          bottom-right = radius;
          top-left = radius;
          top-right = radius;
        };
      clip-to-geometry = true;
      draw-border-with-background = false;
    }
    {
      matches = [
        { is-floating = true; }
      ];
      shadow.enable = true;
    }
    {
      matches = [
        { is-window-cast-target = true; }
      ];
      focus-ring = {
        active.color = "#0d5ba5";
        inactive.color = "#204c78";
      };
      border = {
        inactive.color = "#204c78";
      };
      shadow = {
        color = "#204c7870";
      };
      tab-indicator = {
        active.color = "#0d5ba5";
        inactive.color = "#204c78";
      };
    }
    {
      matches = [ { app-id = "org.telegram.desktop"; } ];
      block-out-from = "screencast";
    }
    {
      matches = [ { app-id = "app.drey.PaperPlane"; } ];
      block-out-from = "screencast";
    }
    {
      matches = [
        { app-id = "vivaldi"; }
        { app-id = "firefox"; }
        { app-id = "chromium-browser"; }
        { app-id = "xdg-desktop-portal-gtk"; }
      ];
      scroll-factor = 0.6;
    }
    {
      matches = [
        { app-id = "vivaldi"; }
        { app-id = "firefox"; }
        { app-id = "chromium-browser"; }
      ];
      open-maximized = true;
    }
    {
      matches = [
        { title = "^Picture-in-Picture$"; }
      ];
      open-floating = true;
      default-floating-position = {
        x = 32;
        y = 32;
        relative-to = "bottom-right";
      };
      default-column-width = {
        fixed = 480;
      };
      default-window-height = {
        fixed = 270;
      };
    }
    {
      matches = [ { title = "Discord Popout"; } ];
      open-floating = true;
      default-floating-position = {
        x = 32;
        y = 32;
        relative-to = "bottom-right";
      };
    }
    # Floating dialogs and utilities
    {
      matches = [ { app-id = "pavucontrol"; } ];
      open-floating = true;
    }
    {
      matches = [ { app-id = "pavucontrol-qt"; } ];
      open-floating = true;
    }
    {
      matches = [ { app-id = "com.saivert.pwvucontrol"; } ];
      open-floating = true;
    }
    {
      matches = [ { app-id = "io.github.fsobolev.Cavalier"; } ];
      open-floating = true;
    }
    {
      matches = [ { app-id = "dialog"; } ];
      open-floating = true;
    }
    {
      matches = [ { app-id = "popup"; } ];
      open-floating = true;
    }
    {
      matches = [ { app-id = "task_dialog"; } ];
      open-floating = true;
    }
    {
      matches = [ { app-id = "gcr-prompter"; } ];
      open-floating = true;
    }
    {
      matches = [ { app-id = "file-roller"; } ];
      open-floating = true;
    }
    {
      matches = [ { app-id = "org.gnome.FileRoller"; } ];
      open-floating = true;
    }
    {
      matches = [ { app-id = "nm-connection-editor"; } ];
      open-floating = true;
    }
    {
      matches = [ { app-id = "blueman-manager"; } ];
      open-floating = true;
    }
    {
      matches = [ { app-id = "xdg-desktop-portal-gtk"; } ];
      open-floating = true;
    }
    {
      matches = [ { app-id = "org.kde.polkit-kde-authentication-agent-1"; } ];
      open-floating = true;
    }
    {
      matches = [ { app-id = "pinentry"; } ];
      open-floating = true;
    }
    # Floating by title
    {
      matches = [ { title = "Progress"; } ];
      open-floating = true;
    }
    {
      matches = [ { title = "File Operations"; } ];
      open-floating = true;
    }
    {
      matches = [ { title = "Copying"; } ];
      open-floating = true;
    }
    {
      matches = [ { title = "Moving"; } ];
      open-floating = true;
    }
    {
      matches = [ { title = "Properties"; } ];
      open-floating = true;
    }
    {
      matches = [ { title = "Downloads"; } ];
      open-floating = true;
    }
    {
      matches = [ { title = "file progress"; } ];
      open-floating = true;
    }
    {
      matches = [ { title = "Confirm"; } ];
      open-floating = true;
    }
    {
      matches = [ { title = "Authentication Required"; } ];
      open-floating = true;
    }
    {
      matches = [ { title = "Notice"; } ];
      open-floating = true;
    }
    {
      matches = [ { title = "Warning"; } ];
      open-floating = true;
    }
    {
      matches = [ { title = "Error"; } ];
      open-floating = true;
    }
  ];
in
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

      window-rules = windowRules;
      layer-rules = [
        {
          matches = [ { namespace = "^noctalia-wallpaper*"; } ];
          place-within-backdrop = true;
        }
      ];

      binds = {
        # Media keys
        "XF86AudioPlay" = {
          allow-when-locked = true;
          action.spawn = [
            "qs"
            "-c"
            "noctalia"
            "ipc"
            "call"
            "media"
            "playPause"
          ];
        };
        "XF86AudioStop" = {
          allow-when-locked = true;
          action.spawn = [
            "qs"
            "-c"
            "noctalia"
            "ipc"
            "call"
            "media"
            "stop"
          ];
        };
        "XF86AudioNext" = {
          allow-when-locked = true;
          action.spawn = [
            "qs"
            "-c"
            "noctalia"
            "ipc"
            "call"
            "media"
            "next"
          ];
        };
        "XF86AudioPrev" = {
          allow-when-locked = true;
          action.spawn = [
            "qs"
            "-c"
            "noctalia"
            "ipc"
            "call"
            "media"
            "previous"
          ];
        };

        # Volume keys
        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn = [
            "qs"
            "-c"
            "noctalia"
            "ipc"
            "call"
            "volume"
            "muteOutput"
          ];
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action.spawn = [
            "qs"
            "-c"
            "noctalia"
            "ipc"
            "call"
            "volume"
            "muteInput"
          ];
        };
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn = [
            "qs"
            "-c"
            "noctalia"
            "ipc"
            "call"
            "volume"
            "increase"
          ];
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn = [
            "qs"
            "-c"
            "noctalia"
            "ipc"
            "call"
            "volume"
            "decrease"
          ];
        };

        # Brightness keys
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          action.spawn = [
            "qs"
            "-c"
            "noctalia"
            "ipc"
            "call"
            "brightness"
            "increase"
          ];
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          action.spawn = [
            "qs"
            "-c"
            "noctalia"
            "ipc"
            "call"
            "brightness"
            "decrease"
          ];
        };

        # System actions
        "Ctrl+Alt+L".action.spawn = [
          "qs"
          "-c"
          "noctalia"
          "ipc"
          "call"
          "lockScreen"
          "lock"
        ];
        "Mod+V".action.spawn = [
          "qs"
          "-c"
          "noctalia"
          "ipc"
          "call"
          "launcher"
          "clipboard"
        ];
        "Mod+E".action.spawn = [
          "qs"
          "-c"
          "noctalia"
          "ipc"
          "call"
          "launcher"
          "emoji"
        ];
        "Mod+U".action.spawn = [
          "qs"
          "-c"
          "noctalia"
          "ipc"
          "call"
          "settings"
          "toggle"
        ];
        "Alt+Space".action.spawn = [
          "qs"
          "-c"
          "noctalia"
          "ipc"
          "call"
          "launcher"
          "toggle"
        ];
        "Mod+D".action.spawn = [
          "qs"
          "-c"
          "noctalia"
          "ipc"
          "call"
          "launcher"
          "toggle"
        ];

        # Screenshots
        "Print".action.screenshot-screen = {
          write-to-disk = true;
        };
        "Mod+Shift+Alt+S".action.screenshot-window = [ ];
        "Mod+Shift+S".action.screenshot = {
          show-pointer = false;
        };

        # Terminal
        "Mod+T".action.spawn = "kitty";

        # Window management
        "Mod+Q".action.close-window = [ ];
        "Mod+S".action.switch-preset-column-width = [ ];
        "Mod+F".action.maximize-column = [ ];
        "Mod+1".action.set-column-width = "25%";
        "Mod+2".action.set-column-width = "50%";
        "Mod+3".action.set-column-width = "75%";
        "Mod+4".action.set-column-width = "100%";
        "Mod+Shift+F".action.expand-column-to-available-width = [ ];
        "Mod+Space".action.toggle-window-floating = [ ];
        "Mod+W".action.toggle-column-tabbed-display = [ ];
        "Mod+Comma".action.consume-window-into-column = [ ];
        "Mod+Period".action.expel-window-from-column = [ ];
        "Mod+C".action.center-visible-columns = [ ];
        "Mod+Tab".action.switch-focus-between-floating-and-tiling = [ ];

        # Resize
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Plus".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Plus".action.set-window-height = "+10%";

        # Focus navigation
        "Mod+H".action.focus-column-left = [ ];
        "Mod+L".action.focus-column-right = [ ];
        "Mod+J".action.focus-window-or-workspace-down = [ ];
        "Mod+K".action.focus-window-or-workspace-up = [ ];
        "Mod+Left".action.focus-column-left = [ ];
        "Mod+Right".action.focus-column-right = [ ];
        "Mod+Down".action.focus-workspace-down = [ ];
        "Mod+Up".action.focus-workspace-up = [ ];

        # Move columns
        "Mod+Shift+H".action.move-column-left = [ ];
        "Mod+Shift+L".action.move-column-right = [ ];
        "Mod+Shift+K".action.move-column-to-workspace-up = [ ];
        "Mod+Shift+J".action.move-column-to-workspace-down = [ ];
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [ ];
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [ ];
      };
    };
  };

  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here
      bar = {
        density = "compact";
        position = "right";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "WiFi";
            }
            {
              id = "Bluetooth";
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Monochrome";
      general = {
        avatarImage = "/home/drfoobar/.face";
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "São Paulo, Brazil";
      };
    };
  };
}
