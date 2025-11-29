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
      gtk3 = {
        input_path = ./matugen-gtk.css;
        output_path = "~/.config/gtk-3.0/matugen.css";
      };
      gtk4 = {
        input_path = ./matugen-gtk.css;
        output_path = "~/.config/gtk-4.0/matugen.css";
      };
    };
  };
}
