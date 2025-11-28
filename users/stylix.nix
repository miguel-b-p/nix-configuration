{
  config,
  pkgs,
  ...
}:
{
  stylix = {
    enable = true;
    polarity = "dark";
    image = ../desktop/wallpaper.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };
  };

  home.packages = with pkgs.nerd-fonts; [
    fira-code
    jetbrains-mono
  ];
}
