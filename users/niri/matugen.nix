{ pkgs, ... }:

{
  programs.matugen = {
    enable = true;
    variant = "dark";
    palette = "dark";
    jsonFormat = "hex";

    # Gruvbox Orange/Yellow seed
    # You can also use "image" path if preferred
    seed = {
      color = "#d79921";
    };

    # Templates for applications
    templates = {
      kitty = {
        input_path = ./templates/kitty-colors.conf;
        output_path = "~/.config/kitty/colors.conf";
      };
      niri = {
        input_path = ./templates/niri-colors.kdl;
        output_path = "~/.config/niri/colors.kdl";
      };
    };
  };
}
