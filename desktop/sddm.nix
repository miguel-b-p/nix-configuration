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
    (pkgs.writeTextDir "share/sddm/themes/Qogir/theme.conf.user" ''
      [General]
      background = "${background-package}"
    '')
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "Qogir";
    extraPackages = [
      custom-qogir-sddm
      background-package
    ];
  };
}
