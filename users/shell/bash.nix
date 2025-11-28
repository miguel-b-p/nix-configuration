{ config, pkgs, ... }:

{

  imports = [
    ./nh.nix
  ];

  home.packages = with pkgs; [
    blesh
  ];
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -l";
      fedora-dev = "distrobox enter fedora-dev";

      sysup = "nh os switch -u";
      rebuild = "nh os switch";
      sysclean = "nh clean all";
    };
    initExtra = ''
      # Outras configurações manuais
      export NH_FLAKE="/home/mingas/nix-configuration"
      eval "$(${pkgs.starship}/bin/starship init bash)"
      [[ $- == *i* ]] && source -- "$(blesh-share)"/ble.sh --attach=none
      # clear
      [[ ! ''${BLE_VERSION-} ]] || ble-attach
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true; # Adiciona uma linha em branco antes do prompt para "respirar"

      # Formato personalizado organizando os módulos
      format = "$directory$git_branch$git_status$package$nodejs$python$rust$golang$docker_context$line_break$character";

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
        vimcmd_symbol = "[V](bold green)";
      };

      # Configuração do diretório (cor azul ciano)
      directory = {
        style = "bold cyan";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      # Configuração do Git (Roxo/Rosa)
      git_branch = {
        symbol = " ";
        style = "bold purple";
      };
      git_status = {
        style = "bold red";
        format = "[$all_status$ahead_behind]($style) ";
      };

      # Ícones para linguagens (só aparecem se o arquivo da linguagem existir)
      nodejs = {
        symbol = " ";
        style = "bold green";
      };
      python = {
        symbol = "🐍 ";
        style = "bold yellow";
      };
      rust = {
        symbol = "🦀 ";
        style = "bold red";
      };
      golang = {
        symbol = "🐹 ";
        style = "bold cyan";
      };
      package = {
        symbol = "📦 ";
        disabled = false;
      };
    };
  };
}
