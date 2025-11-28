{ config, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    fontconfig.cache32Bit = true;
    fontconfig.enable = true;
  };
}
