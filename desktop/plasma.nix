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
  ];
  environment.systemPackages = with pkgs; [
    # KDE stuff
    kdePackages.partitionmanager
    kdePackages.kcalc
    tela-icon-theme
    ffmpegthumbnailer
  ];
  services.libinput.enable = true;

}
