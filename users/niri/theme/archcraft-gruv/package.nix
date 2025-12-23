{
  stdenvNoCC,
  lib,
}:

stdenvNoCC.mkDerivation {
  pname = "gruvbox-light-gtk-theme";
  version = "1.0.0";

  src = ./src;

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/themes/Gruvbox-Light
    cp -r ./* $out/share/themes/Gruvbox-Light/

    runHook postInstall
  '';

  meta = with lib; {
    description = "Gruvbox Light GTK theme based on Archcraft";
    homepage = "https://github.com/archcraft-os/archcraft-themes";
    license = licenses.gpl3Plus;
    platforms = platforms.all;
    maintainers = [ ];
  };
}
