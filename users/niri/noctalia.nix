{ pkgs, config, ... }:
{
  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "comfortable";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "Tray";
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
            {
              id = "SystemMonitor";
              cpuUsage = true;
              cpuTemperature = true;
              gpuTemperature = true;
              memoryUsage = true;
              memoryAsPercentage = true;
              networkTraffic = true;
              storageUsage = true;
              usePrimaryColor = true;
            }
          ];
          right = [
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
  programs.noctalia-shell.systemd.enable = true;
}
