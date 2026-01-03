{ ... }:
{
  programs.niri.settings.binds = {
    "XF86AudioPlay" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "mpris"
        "playPause"
      ];
    };
    "XF86AudioStop" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "mpris"
        "stop"
      ];
    };
    "XF86AudioNext" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "mpris"
        "next"
      ];
    };
    "XF86AudioPrev" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "mpris"
        "previous"
      ];
    };

    "XF86AudioMute" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "mute"
      ];
    };
    "XF86AudioMicMute" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "micmute"
      ];
    };
    "XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "increment"
        "5"
      ];
    };
    "XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "decrement"
        "5"
      ];
    };

    "XF86MonBrightnessUp" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "brightness"
        "increment"
        "5"
        ""
      ];
    };
    "XF86MonBrightnessDown" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "brightness"
        "decrement"
        "5"
        ""
      ];
    };

    "Ctrl+Alt+L".action.spawn = [
      "dms"
      "ipc"
      "call"
      "lock"
      "lock"
    ];
    "Mod+V".action.spawn = [
      "dms"
      "ipc"
      "call"
      "clipboard"
      "toggle"
    ];
    "Mod+E".action.spawn = [
      "dms"
      "ipc"
      "call"
      "spotlight"
      "toggleQuery"
      ":"
    ];
    "Mod+U".action.spawn = [
      "dms"
      "ipc"
      "call"
      "settings"
      "toggle"
    ];
    "Alt+Space".action.spawn = [
      "dms"
      "ipc"
      "call"
      "spotlight"
      "toggle"
    ];

    "Print".action.screenshot-screen = {
      write-to-disk = true;
    };
    "Mod+Alt+Print".action.screenshot-window = [ ];
    "Mod+Shift+Print".action.screenshot = {
      show-pointer = false;
    };

    "Mod+G".action.spawn = "ghostty";

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

    "Mod+Alt+Left".action.set-column-width = "-10%";
    "Mod+Alt+Right".action.set-column-width = "+10%";
    "Mod+Alt+Up".action.set-window-height = "-10%";
    "Mod+Alt+Down".action.set-window-height = "+10%";

    "Mod+Left".action.focus-column-left = [ ];
    "Mod+Right".action.focus-column-right = [ ];
    "Mod+Down".action.focus-workspace-down = [ ];
    "Mod+Up".action.focus-workspace-up = [ ];

    "Mod+Shift+Left".action.move-column-left = [ ];
    "Mod+Shift+Right".action.move-column-right = [ ];
    "Mod+Shift+Up".action.move-column-to-workspace-up = [ ];
    "Mod+Shift+Down".action.move-column-to-workspace-down = [ ];

  };
}
