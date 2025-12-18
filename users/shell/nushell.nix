{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    environmentVariables = {
      NH_FLAKE = "/home/mingas/nix-configuration";
    };
  };
}
