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
      cp -r sddm/Qogir $out/share/sddm/themes/Qogir-sddm
      echo "[General]" > $out/share/sddm/themes/Qogir-sddm/theme.conf.user
      echo "background=${background-package}" >> $out/share/sddm/themes/Qogir-sddm/theme.conf.user
      echo "type=image" >> $out/share/sddm/themes/Qogir-sddm/theme.conf.user
    '';
  };

  background-package = pkgs.stdenvNoCC.mkDerivation {
    name = "background-image";
    src = ./wallpaper.jpg;
    dontUnpack = true;
    installPhase = ''
      cp $src $out
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
    theme = "Qogir-sddm";
    extraPackages = [
      custom-qogir-sddm
    ];
  };
}
