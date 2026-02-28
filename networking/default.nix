{ config, ... }:

{

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  hardware.enableAllFirmware = true;
}
