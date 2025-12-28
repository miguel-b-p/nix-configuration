{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./boot
    ./hardware/amdgpu.nix
    ./hardware/drives
    ./networking
    ./localization
    ./services/audio.nix
    ./services/printing.nix
    ./services/flatpak.nix
    ./services/performance.nix
    ./services/udev.nix
    ./programs/steam.nix
    ./programs/lact.nix
    ./programs/steam-run.nix
    ./programs/warp-cloudflare.nix
    ./programs/warp-terminal
    ./programs/packages.nix
    ./programs/file-manager.nix
    ./system/kernel.nix
    ./system/packages.nix
    ./system/fonts.nix
    ./system/nixos.nix
    # ./system/unbound.nix
    ./system/xdg.nix
    ./virtualization
    ./users
    ./desktop/greetd.nix
  ];

  programs.dconf.enable = true;

  system.stateVersion = "26.05";
}
