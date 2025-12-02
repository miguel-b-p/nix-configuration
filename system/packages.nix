{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    appimage-run
    wayland-utils

    btop

    cacert
    curl
    jq
    moreutils
    nix
    nixfmt
    wget
    iw
    usbutils
    pciutils
  ];

  programs.ydotool.enable = true;
}
