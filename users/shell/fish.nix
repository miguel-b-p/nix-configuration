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

    # plugins = [
    #   {
    #     name = "hydro";
    #     src = pkgs.fishPlugins.hydro.src;
    #   }
    # ];
  };

  # home.packages = with pkgs; [
  #   fishPlugins.hydro
  # ];
}
