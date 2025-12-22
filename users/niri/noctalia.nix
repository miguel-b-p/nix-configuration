{ pkgs, config, ... }:
{
  programs.noctalia-shell = {
    enable = true;

    settings = {
      colorSchemes = {
        useWallpaperColors = false; # Desliga cores do wallpaper para usar predefined
        predefinedScheme = "Gruvbox"; # Aqui o nome exato do tema (capital G maiúsculo)
        darkMode = true; # Ou false se quiser light, mas Gruvbox é dark
        # schedulingMode = "off";  # Opcional, se não quiser schedule automático
        generateTemplatesForPredefined = false; # Opcional, para aplicar em apps como GTK/Qt
      };
      bar = {
        density = "comfortable";
        position = "top";
        showCapsule = true; # Ativa "Show capsule" (fundo arredondado nos widgets)
        showWidgetBackgrounds = true; # Ativa "Show widget backgrounds" (pelo nome na GUI; em algumas versões pode ser widgetBackgrounds ou similar – confirme nos defaults)
        capsuleOpacity = 0.60; # Define "Capsule opacity" em 60% (valor entre 0.0 e 1.0)
        floating = true;
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
        enabled = false;
      };

      general = {
        avatarImage = "/home/mingas/face.jpg";
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
