{ ... }:
{
  programs.niri.settings.binds = {
    # Media keys
    "XF86AudioPlay" = {
      allow-when-locked = true;
      action.spawn = [
        "noctalia-shell"
        "ipc"
        "call"
        "media"
        "playPause"
      ];
    };
    "XF86AudioStop" = {
      allow-when-locked = true;
      action.spawn = [
        "noctalia-shell"
        "ipc"
        "call"
        "media"
        "stop"
      ];
    };
    "XF86AudioNext" = {
      allow-when-locked = true;
      action.spawn = [
        "noctalia-shell"
        "ipc"
        "call"
        "media"
        "next"
      ];
    };
    "XF86AudioPrev" = {
      allow-when-locked = true;
      action.spawn = [
        "noctalia-shell"
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
        "noctalia-shell"
        "ipc"
        "call"
        "volume"
        "muteOutput"
      ];
    };
    "XF86AudioMicMute" = {
      allow-when-locked = true;
      action.spawn = [
        "noctalia-shell"
        "ipc"
        "call"
        "volume"
        "muteInput"
      ];
    };
    "XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action.spawn = [
        "noctalia-shell"
        "ipc"
        "call"
        "volume"
        "increase"
      ];
    };
    "XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action.spawn = [
        "noctalia-shell"
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
        "noctalia-shell"
        "ipc"
        "call"
        "brightness"
        "increase"
      ];
    };
    "XF86MonBrightnessDown" = {
      allow-when-locked = true;
      action.spawn = [
        "noctalia-shell"
        "ipc"
        "call"
        "brightness"
        "decrease"
      ];
    };

    # System actions
    "Ctrl+Alt+L".action.spawn = [
      "noctalia-shell"
      "ipc"
      "call"
      "lockScreen"
      "lock"
    ];
    "Mod+V".action.spawn = [
      "noctalia-shell"
      "ipc"
      "call"
      "launcher"
      "clipboard"
    ];
    "Mod+E".action.spawn = [
      "noctalia-shell"
      "ipc"
      "call"
      "launcher"
      "emoji"
    ];
    "Mod+U".action.spawn = [
      "noctalia-shell"
      "ipc"
      "call"
      "settings"
      "toggle"
    ];
    "Alt+Space".action.spawn = [
      "noctalia-shell"
      "ipc"
      "call"
      "launcher"
      "toggle"
    ];

    # Screenshots
    "Print".action.screenshot-screen = {
      write-to-disk = true;
    };
    "Mod+Alt+Print".action.screenshot-window = [ ];
    "Mod+Shift+Print".action.screenshot = {
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
    "Mod+Shift+Space".action.fullscreen-window = [ ];

    # Resize
    "Mod+Alt+Left".action.set-column-width = "-10%";
    "Mod+Alt+Right".action.set-column-width = "+10%";
    "Mod+Alt+Up".action.set-window-height = "-10%";
    "Mod+Alt+Down".action.set-window-height = "+10%";

    # Focus navigation
    "Mod+Left".action.focus-column-left = [ ];
    "Mod+Right".action.focus-column-right = [ ];
    "Mod+Down".action.focus-workspace-down = [ ];
    "Mod+Up".action.focus-workspace-up = [ ];

    # Move columns
    "Mod+Shift+Left".action.move-column-left = [ ];
    "Mod+Shift+Right".action.move-column-right = [ ];
    "Mod+Shift+Up".action.move-column-to-workspace-up = [ ];
    "Mod+Shift+Down".action.move-column-to-workspace-down = [ ];
  };
}
