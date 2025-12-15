{ config, pkgs, ... }:

let
  custom-qogir-sddm = pkgs.stdenv.mkDerivation {
    name = "qogir-sddm-theme";
    src = pkgs.fetchFromGitHub {
      owner = "vinceliuice";
      repo = "Qogir-kde";
      rev = "master";
      sha256 = "zgXwYmpD31vs2Gyg21m0MdOkwqzSn6V21Kva+nvNeVI=";
    };

    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -r sddm/Qogir $out/share/sddm/themes/Qogir

      # Copy user background
      mkdir -p $out/share/sddm/themes/Qogir/backgrounds
      cp -r ${./background.jpg} $out/share/sddm/themes/Qogir/backgrounds/background.jpg
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
    extraPackages = [ custom-qogir-sddm ];
  };
}
