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
            # 1. Pegamos o pacote base JÁ COMPILADO (cache oficial)
            basePkg = prev.kdePackages.plasma-workspace;

            # 2. Helper package que une os XDG_DATA_DIRS (Mantido igual à sua lógica)
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

                # Link from basePkg itself
                if [[ -d "${basePkg}/share" ]]; then
                  ${prev.xorg.lndir}/bin/lndir -silent "${basePkg}/share" "$out/share" || true
                fi

                # Link from propagated inputs
                for input in $buildInputs; do
                  if [[ -d "$input/share" ]]; then
                    ${prev.xorg.lndir}/bin/lndir -silent "$input/share" "$out/share" || true
                  fi
                done

                runHook postInstall
              '';
            };

            # 3. NOVO MÉTODO: Em vez de overrideAttrs, usamos symlinkJoin + sed
            # Isso cria um novo pacote composto de links para o original,
            # mas copiamos e editamos apenas os executáveis wrapper.
            patchedPkg = prev.symlinkJoin {
              name = "${basePkg.name}-patched";
              paths = [ basePkg ];
              nativeBuildInputs = [ prev.makeWrapper ];
              passthru = basePkg.passthru; # Preserve providedSessions for display manager

              postBuild = ''
                # Entra na pasta bin do novo pacote (que atualmente só tem symlinks)
                cd $out/bin

                # Procura por todos os arquivos no diretório
                for f in *; do
                  # Verifica se é um arquivo (symlink válido) e se contém a string alvo
                  # grep -q segue o symlink automaticamente
                  if [ -f "$f" ] && grep -q "XDG_DATA_DIRS" "$f"; then
                    
                    # Remove o symlink e copia o arquivo real do basePkg
                    # --remove-destination garante que o link seja quebrado
                    cp --remove-destination "$(readlink -f $f)" "$f"
                    chmod +w "$f"

                    # HACK BINÁRIO: Substitui a variável XDG_DATA_DIRS por uma dummy (IGG_DATA_DIRS)
                    # Mantém o mesmo número de bytes, então o binário não quebra.
                    # Isso desativa a injeção da lista gigante original.
                    LC_ALL=C sed -i 's/XDG_DATA_DIRS/IGG_DATA_DIRS/g' "$f"

                    # Renomeia o binário "sabotado" para .patched
                    mv "$f" "$f.patched"

                    # Cria um novo wrapper leve que injeta APENAS o nosso xdgdataPkg
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
  ];

  environment.sessionVariables = {
    KWIN_COMPOSE = "O2ES";
    # KWIN_DRM_NO_DIRECT_SCANOUT = "O2ES";
    # QT_QUICK_BACKEND = "software";
    # LIBGL_ALWAYS_SOFTWARE = "0";
  };

  services.libinput.enable = true;
}
