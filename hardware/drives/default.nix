{ pkgs, ... }:
{
  imports = [
    ./bkp.nix
    ./husky.nix
  ];
  environment.systemPackages = with pkgs; [
    ntfs3g
    btrfs-progs
  ];

  services.fstrim.enable = true;
}
