{ config, pkgs, ... }:

{
  fonts = {
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
    packages = with pkgs; [
      dejavu_fonts
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji
      # Adicione estes pacotes para suporte a Japonês/CJK
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = false;
        style = "full";
      };
      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };
      defaultFonts = {
        # Adicione "Noto Sans CJK JP" como fallback
        sansSerif = [
          "DejaVu Sans"
          "Noto Sans CJK JP"
        ];
        serif = [
          "DejaVu Serif"
          "Noto Serif CJK JP"
        ];
        monospace = [
          "JetBrainsMono Nerd Font"
          "Noto Sans Mono CJK JP"
        ];
        emoji = [ "Noto Color Emoji" ];
      };

      cache32Bit = true;
    };
  };
}
