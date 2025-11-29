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
      set fish_greeting  # sem mensagem inicial
    '';

    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "hydro";
        src = pkgs.fishPlugins.hydro.src;
      }
    ];
  };

  home.packages = with pkgs; [
    fishPlugins.fzf-fish
    fishPlugins.hydro
  ];
}
