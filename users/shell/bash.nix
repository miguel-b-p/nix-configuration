{ config, pkgs, ... }:

{

  imports = [
    ./nh.nix
  ];

  home.packages = with pkgs; [
    # blesh
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
      # eval "$(${pkgs.starship}/bin/starship init bash)"
      # [[ $- == *i* ]] && source -- "$(blesh-share)"/ble.sh --attach=none
      # # clear
      # [[ ! ''${BLE_VERSION-} ]] || ble-attach
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      format = "\n $all \n";
      right_format = "$time";

      # Paleta baseada no wallpaper
      palette = "wallpaper";

      palettes = {
        wallpaper = {
          base = "#181A33";
          accent = "#F3D2E1";
          accent_alt = "#37375B";
          accent_dim = "#625A81";
          accent_soft = "#A589A8";
        };
      };

      directory = {
        style = "fg:accent_soft";
        truncation_length = 4;
        truncate_to_repo = true;
        fish_style_pwd_dir_length = 3;
        substitutions = {
          "Documents" = " 󰧮 ";
          "Music" = "  ";
          "Movies" = " 󰿏 ";
          "Pictures" = " ";
          "Sources" = "  ";
          "Downloads" = "  ";
          "~" = "  ";
          "/" = "  ";
        };
      };

      line_break = {
        disabled = true;
      };

      character = {
        success_symbol = " [󰁔](fg:accent) ";
        error_symbol = " [ ](fg:accent_soft)[ ](fg:accent_soft) ";
        format = "$symbol";
        disabled = false;
      };

      git_branch = {
        disabled = false;
        symbol = " ";
        style = "fg:accent_soft";
        truncation_length = 5;
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };

      git_commit = {
        disabled = false;
        commit_hash_length = 1;
      };

      git_state = {
        disabled = false;
        rebase = "rebasing";
        merge = "merging";
        revert = "reverting";
        cherry_pick = " picking";
        bisect = "bisecting";
        am = "am'ing";
        am_or_rebase = "am/rebase";
      };

      git_status = {
        disabled = false;
        style = "fg:accent_dim";
        stashed = "  \${count} ";
        ahead = " 󰞙 \${count} ";
        behind = " 󰞒 \${count} ";
        diverged = " 󰵉 \${ahead_count} \${behind_count} ";
        conflicted = " \${count} ";
        deleted = "  \${count} ";
        renamed = "  \${count} ";
        modified = "  \${count} ";
        staged = "  \${count} ";
        untracked = " 󱅘 \${count}";
      };

      java = {
        disabled = false;
        symbol = "•  ";
        format = "[\${symbol}]($style)";
        style = "fg:accent_soft";
      };

      python = {
        disabled = false;
        pyenv_version_name = false;
        python_binary = "python";
        format = "[\${symbol}(\\($virtualenv\\))]($style)";
        style = "fg:accent_soft";
        symbol = "• 󱔎 ";
      };

      lua = {
        disabled = false;
        symbol = "• ";
        format = "[\${symbol}]($style)";
        style = "fg:accent_soft";
      };

      nodejs = {
        disabled = false;
        symbol = "• 󰎙 ";
        format = "[\${symbol}]($style)";
        style = "fg:accent_soft";
      };

      package = {
        disabled = false;
        symbol = "•  ";
        display_private = false;
        format = "[\${symbol}]($style)";
        style = "fg:accent_soft";
      };

      docker_context = {
        disabled = false;
        symbol = "•  ";
        only_with_files = true;
        format = "[\${symbol}]($style)";
        style = "fg:accent_soft";
      };

      golang = {
        disabled = false;
        symbol = "•  ";
        format = "[\${symbol}]($style)";
        style = "fg:accent_soft";
      };
    };
  };

}
