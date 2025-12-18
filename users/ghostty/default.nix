{pkgs, ...}:
{
  programs.ghostty = {
    enable = true;
    settings = {
      background = "#282828";
      foreground = "#ebdbb2";
      cursor-color = "#928374";
      cursor-text = "#282828";
      selection-background = "#ebdbb2";
      selection-foreground = "#928374";
      palette = [
        "0=#665c54"
        "1=#cc241d"
        "2=#98971a"
        "3=#d79921"
        "4=#458588"
        "5=#b16286"
        "6=#689d6a"
        "7=#a89984"
        "8=#7c6f64"
        "9=#fb4934"
        "10=#b8bb26"
        "11=#fabd2f"
        "12=#83a598"
        "13=#d3869b"
        "14=#8ec07c"
        "15=#bdae93"
      ];
    };
}