{ inputs, ... }:

{
  programs.matugen = {
    enable = true;
    variant = "dark";
    wallpaper = ./wallpaper.jpg;
    templates = {
      kde-colors = {
        input_path = ./matugen-kde.colors;
        output_path = "~/.local/share/color-schemes/Matugen.colors";
      };
    };
  };
}
