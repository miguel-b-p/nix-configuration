{ config, ... }:

{
  networking = {
    hostName = "NixOS";
    networkmanager.enable = true;
  };
}
