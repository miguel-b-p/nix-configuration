{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    environmentVariables = {
      NH_FLAKE = "/home/mingas/nix-configuration";
    };
    extraConfig = ''
      $env.config.show_banner = false
    ''
    + builtins.readFile ./fzf-config.nu;
  };
}
