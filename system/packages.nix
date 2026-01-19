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
  ];

  programs.ydotool.enable = true;
}
