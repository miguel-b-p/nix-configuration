{ config, pkgs, ... }:

{

  imports = [
    ./nh.nix
  ];

  home.packages = with pkgs; [
    blesh
  ];

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = [ "--cmd cd" ];
  };
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
      # [[ $- == *i* ]] && source -- "$(blesh-share)"/ble.sh --attach=none
      # # clear
      # [[ ! ''${BLE_VERSION-} ]] || ble-attach
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };

}
