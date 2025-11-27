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
    # Força o renderizador do KWin para software (QPainter)
    # Muitos problemas, algumas janelas nem funcionam direito
    # KWIN_COMPOSE = "Q";
    KWIN_COMPOSE = "O2ES";

    # Força o backend do Qt Quick para software
    # QT_QUICK_BACKEND = "software";

    # Desativa aceleração OpenGL (usará llvmpipe/softpipe)
    # LIBGL_ALWAYS_SOFTWARE = "1";
  };
  services.libinput.enable = true;

}
