{ config, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    fontconfig.cache32Bit = true;
    packages =
      with pkgs;
      [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        liberation_ttf
        cantarell-fonts
        poppins
      ]
      ++ (with pkgs.nerd-fonts; [
        jetbrains-mono
        fira-code
      ]);
  };
}
