{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      background = "#fbf1c7";
      foreground = "#3c3836";
      cursor-color = "#3c3836";
      cursor-text = "#fbf1c7";
      selection-background = "#ebdbb2";
      selection-foreground = "#3c3836";
      palette = [
        "0=#fbf1c7"
        "1=#9d0006"
        "2=#79740e"
        "3=#b57614"
        "4=#076678"
        "5=#8f3f71"
        "6=#427b58"
        "7=#7c6f64"
        "8=#928374"
        "9=#9d0006"
        "10=#79740e"
        "11=#b57614"
        "12=#076678"
        "13=#8f3f71"
        "14=#427b58"
        "15=#3c3836"
      ];
    };
  };
}
