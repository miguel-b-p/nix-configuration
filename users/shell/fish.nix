{
  pkgs,
  config,
  lib,
  ...
}:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -gx NH_FLAKE "/home/mingas/nix-configuration"
      set fish_greeting  # sem mensagem inicial
    '';
  };
}
