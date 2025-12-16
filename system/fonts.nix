{ config, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    fontconfig.cache32Bit = true;
    fontconfig.enable = true;
    packages = with pkgs.nerd-fonts; [
      fira-code
      jetbrains-mono
    ];
  };
}
