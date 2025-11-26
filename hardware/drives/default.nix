{ pkgs, ... }:
{
  imports = [
    ./bkp.nix
    ./husky.nix
  ];
  environment.systemPackages = with pkgs; [
    ntfs3g
  ];
  
  services.fstrim.enable = true;
}
