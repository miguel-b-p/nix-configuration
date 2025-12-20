{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  xdg = {
    enable = true; # Opcional, mas recomendado
    mimeApps = {
      enable = true;
      defaultApplications = {
        # Navegador padrão: Vivaldi para web e URLs
        "text/html" = "vivaldi-stable.desktop";
        "x-scheme-handler/http" = "vivaldi-stable.desktop";
        "x-scheme-handler/https" = "vivaldi-stable.desktop";
        "x-scheme-handler/about" = "vivaldi-stable.desktop";
        "x-scheme-handler/unknown" = "vivaldi-stable.desktop";

        # Explorador de arquivos: Nautilus para pastas
        "inode/directory" = "org.gnome.Nautilus.desktop";

        # Imagens
        "image/*" = "org.gnome.Loupe.desktop";
        "image/jpeg" = "org.gnome.Loupe.desktop";
        "image/png" = "org.gnome.Loupe.desktop";
        "image/gif" = "org.gnome.Loupe.desktop";
        "image/webp" = "org.gnome.Loupe.desktop";

        # Vídeos
        "video/*" = "vlc.desktop";
        "video/mp4" = "vlc.desktop";
        "video/x-matroska" = "vlc.desktop";

        # PDF e Documentos
        "application/pdf" = "org.gnome.Evince.desktop";

        # Arquivos compactados
        "application/zip" = "org.gnome.FileRoller.desktop";
        "application/x-tar" = "org.gnome.FileRoller.desktop";
        "application/x-bzip2" = "org.gnome.FileRoller.desktop";
        "application/x-gzip" = "org.gnome.FileRoller.desktop";

        # Texto
        "text/plain" = "org.gnome.TextEditor.desktop";

        # Opcional: mais MIME comuns para reforçar
        "application/x-gnome-saved-search" = "org.gnome.Nautilus.desktop";
      };
    };
  };
}
