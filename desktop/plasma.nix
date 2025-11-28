{ config, pkgs, ... }:

{
  services = {
    xserver.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    baloo
    discover
  ];
  environment.systemPackages = with pkgs; [
    # KDE stuff
    kdePackages.partitionmanager
    kdePackages.kcalc
    tela-icon-theme
    ffmpegthumbnailer

    gnome-software
  ];

  environment.sessionVariables = {
    #    KWIN_COMPOSE = "O";
    # KWIN_DRM_NO_DIRECT_SCANOUT = "0";

    # Força o backend do Qt Quick para software
    # QT_QUICK_BACKEND = "software";

    # Desativa aceleração OpenGL (usará llvmpipe/softpipe)
    # LIBGL_ALWAYS_SOFTWARE = "0";
  };
  services.libinput.enable = true;

  stylix = {
    enable = true;
    image = ./wallpaper.png; # Sua imagem base
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml"; # Opcional: forçar um esquema

    # Unificar fontes
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = {
        package = pkgs.nerdfonts;
        name = "JetBrainsMono Nerd Font";
      };
    };
  };

}
