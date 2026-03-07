{ config, pkgs, ... }:

{
  programs.droidcam.enable = true;

  environment.systemPackages = with pkgs; [
    android-tools
  ];

  users.users.mingas.extraGroups = [ "wheel" ];

  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="DroidCam"
  '';

  boot.kernelModules = [
    "v4l2loopback"
    "snd-aloop"
  ];
}
