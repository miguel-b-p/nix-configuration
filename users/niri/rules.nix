{ ... }:
{
  programs.niri.settings.window-rules = [
    {
      matches = [
        { app-id = "Discovery-d.exe"; }
        { app-id = "cs2"; }
      ];
      open-fullscreen = true;
      block-out-from = "screen-capture";
      shadow.enable = false;

      # Performance optimizations
      opacity = 1.0;
      geometry-corner-radius = {
        top-left = 0.0;
        top-right = 0.0;
        bottom-left = 0.0;
        bottom-right = 0.0;
      };
      clip-to-geometry = false;
      variable-refresh-rate = true;
    }
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
        { app-id = "antigravity"; }
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
}
