{ config, pkgs, ... }:

let
  custom-qogir-sddm = pkgs.qogir-sddm.override {
    themeConfig.General = {
      background = toString ./wall.jpg;
      # se o tema suportar:
      # backgroundMode = "fill";
    };
  };
in
{
  environment.systemPackages = with pkgs; [
    custom-qogir-sddm
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "Qogir"; # nome do tema na pasta /share/sddm/themes
    extraPackages = [ custom-qogir-sddm ];
  };
}
