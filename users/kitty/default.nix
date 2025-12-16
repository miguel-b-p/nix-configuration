{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.kitty = {
    enable = true;
    # extraConfig = builtins.readFile ./macchiato.conf;
  };
}
