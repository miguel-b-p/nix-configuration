{ pkgs, ... }:
{
  services.udisks2.enable = true; # Essencial para gerenciamento e montagem de discos via DBus
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    nautilus
  ];
}
