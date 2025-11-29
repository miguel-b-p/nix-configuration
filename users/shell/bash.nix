{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      export NH_FLAKE="/home/mingas/nix-configuration"
    '';
  };
}
