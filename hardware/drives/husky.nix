{ lib, ... }:
{
  fileSystems."/mnt/husky" = {
    device = "/dev/disk/by-uuid/5bf5a70f-64a4-4844-bfcb-3c6515bf138c";
    fsType = "btrfs";
    options = [
      "defaults"
      "user"
      "rw"
      "compress=zstd:3"
      "ssd"
      "noatime"
      "x-gvfs-show"
    ];
  };
}
