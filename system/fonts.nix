{ config, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      dejavu_fonts
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "DejaVu Sans" ];
        serif = [ "DejaVu Serif" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };

      cache32Bit = true;
    };
  };
}
