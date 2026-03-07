{ config, pkgs, ... }:

{
  programs.droidcam.enable = true;
  programs.adb.enable = true;
  users.users.mingas.extraGroups = [ "adbusers" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="DroidCam"
  '';
  boot.kernelModules = [
    "v4l2loopback"
    "snd-aloop"
  ];
}
