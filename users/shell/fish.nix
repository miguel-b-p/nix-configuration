{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting  # sem mensagem inicial
    '';

    # Se usar Home Manager, dá para declarar plugins assim:
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

  environment.systemPackages = with pkgs; [
    fish
    fishPlugins.fzf-fish
    fishPlugins.hydro
  ];
}
