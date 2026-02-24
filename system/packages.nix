{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    appimage-run
    wayland-utils

    btop
    fastfetch

    cacert
    curl
    jq
    moreutils
    nixfmt
    wget
    iw
    usbutils
    pciutils
    wl-clipboard
    icu

    # Dev and rocm
    glibc
    gcc
    gnumake
    zstd
    cmake
    gccNGPackages_15.libstdcxx

  ];

  programs.ydotool.enable = true;
}
