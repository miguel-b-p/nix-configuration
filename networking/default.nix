{ config, ... }:

{

  networking = {
    hostName = "NixOS";
    networkmanager.enable = true;
  };
  hardware.enableAllFirmware = true;
}
