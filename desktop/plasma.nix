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
  services.libinput.enable = true;

}
