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
            { id = "Tray"; }
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
              id = "Clock";
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      dock = {
        enable = false;
      };

      general = {
        avatarImage = "/home/mingas/.face";
        radiusRatio = 0.2;
      };

      location = {
        monthBeforeDay = true;
        name = "São Paulo, Brazil";
      };
    };
  };

  # Preferível: só UM lugar habilita o serviço (você já está usando HM, então ok)
  programs.noctalia-shell.systemd.enable = true;
}
