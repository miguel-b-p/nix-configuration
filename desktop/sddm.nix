{ config, pkgs, ... }:

let
  custom-qogir-sddm = pkgs.stdenv.mkDerivation {
    name = "qogir-sddm-theme";
    src = ./sddm/Qogir;
  };
in
{
  environment.systemPackages = with pkgs; [
    custom-qogir-sddm
    qogir-icon-theme
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "Qogir"; # nome do tema na pasta /share/sddm/themes
    extraPackages = with pkgs.kdePackages; [
      custom-qogir-sddm
      qtsvg
      qtmultimedia
      qtvirtualkeyboard
    ];
  };
}
