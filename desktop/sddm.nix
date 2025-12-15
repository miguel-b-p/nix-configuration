{ config, pkgs, ... }:

let
  custom-qogir-sddm = pkgs.stdenv.mkDerivation {
    name = "qogir-sddm-theme";
    src = ./sddm/Qogir;

    installPhase = ''
      rm -rf $out/share/sddm/themes/Qogir
      mkdir -p $out/share/sddm/themes
      cp -r $src $out/share/sddm/themes/Qogir
      chmod -R +w $out/share/sddm/themes/Qogir
    '';
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
  };
}
