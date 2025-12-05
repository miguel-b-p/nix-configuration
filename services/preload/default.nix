{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./preload.nix
  ];
}
