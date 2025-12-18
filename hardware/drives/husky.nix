{ lib, ... }:
{
  fileSystems."/mnt/husky" = lib.mkForce {
    device = "/dev/disk/by-uuid/d284b8ab-12d4-44c3-8cd0-fed4f96a3d51";
    fsType = "btrfs";
    options = [
      "rw"
      "noatime"
      "compress=zstd"
      "nofail"
      "x-gvfs-show"
      "x-systemd.mount-timeout=5"
    ];
  };
}
