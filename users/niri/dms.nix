{ pkgs, config, ... }:
{
  programs.dankMaterialShell = {
    enable = true;
    niri = {
      enableKeybinds = true; # Sets static preset keybinds
      enableSpawn = true; # Auto-start DMS with niri and cliphist, if enabled
    };
  };
}
