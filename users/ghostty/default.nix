{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "dankcolors";
    };
  };
}
