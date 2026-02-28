{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    steam-run
  ];
  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override {
        extraPkgs =
          ps: with ps; [
            alsa-lib
            at-spi2-atk
            at-spi2-core
            atk
            cairo
            curl
            dbus
            expat
            fontconfig
            freetype
            fuse
            fuse3
            gdk-pixbuf
            glib
            gtk3
            gsettings-desktop-schemas
            harfbuzz
            icu
            libGL
            libappindicator-gtk3
            libdrm
            libglvnd
            libnotify
            libpulseaudio
            libunwind
            libusb1
            libuuid
            libsoup_3
            libxkbcommon
            libxml2
            mesa
            nspr
            nss
            openssl
            pango
            pipewire
            stdenv.cc.cc
            systemd
            vulkan-loader
            webkitgtk_4_1
            libX11
            libXScrnSaver
            libXcomposite
            libXcursor
            libXdamage
            libXext
            libXfixes
            libXi
            libXrandr
            libXrender
            libXtst
            libxcb
            libxkbfile
            libxshmfence
            zlib
          ];
      };
    })
  ];
}
