{
  config,
  pkgs,
  lib,
  ...
}:

{
  nixpkgs.overlays = lib.singleton (
    final: prev: {
      kdePackages = prev.kdePackages // {
        plasma-workspace =
          let
            basePkg = prev.kdePackages.plasma-workspace;

            xdgdataPkg = prev.stdenv.mkDerivation {
              name = "${basePkg.name}-xdgdata";
              dontUnpack = true;
              dontFixup = true;
              dontWrapQtApps = true;

              buildInputs = basePkg.propagatedBuildInputs or [ ];
              nativeBuildInputs = [ prev.xorg.lndir ];

              installPhase = ''
                runHook preInstall
                mkdir -p $out/share

                if [[ -d "${basePkg}/share" ]]; then
                  ${prev.xorg.lndir}/bin/lndir -silent "${basePkg}/share" "$out/share" || true
                fi
                for input in $buildInputs; do
                  if [[ -d "$input/share" ]]; then
                    ${prev.xorg.lndir}/bin/lndir -silent "$input/share" "$out/share" || true
                  fi
                done

                runHook postInstall
              '';
            };

            patchedPkg = prev.symlinkJoin {
              name = "${basePkg.name}-patched";
              paths = [ basePkg ];
              nativeBuildInputs = [ prev.makeWrapper ];
              passthru = basePkg.passthru;

              postBuild = ''
                cd $out/bin

                for f in *; do
                  if [ -f "$f" ] && grep -q "XDG_DATA_DIRS" "$f"; then
                    
                    cp --remove-destination "$(readlink -f $f)" "$f"
                    chmod +w "$f"

                    LC_ALL=C sed -i 's/XDG_DATA_DIRS/IGG_DATA_DIRS/g' "$f"

                    mv "$f" "$f.patched"

                    makeWrapper "$out/bin/$f.patched" "$out/bin/$f" \
                      --prefix XDG_DATA_DIRS : "${xdgdataPkg}/share" \
                      --prefix XDG_DATA_DIRS : "$out/share"
                  fi
                done
              '';
            };

          in
          patchedPkg;
      };
    }
  );

  services = {
    xserver.enable = true;
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
  ];

  environment.sessionVariables = {
    KWIN_COMPOSE = "O2ES";
    # KWIN_DRM_NO_DIRECT_SCANOUT = "O2ES";
    # QT_QUICK_BACKEND = "software";
    # LIBGL_ALWAYS_SOFTWARE = "0";
  };

  services.libinput.enable = true;

  imports = [
    ./sddm.nix
  ];
}
