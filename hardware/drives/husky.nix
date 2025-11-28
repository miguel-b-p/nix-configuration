{ lib, ... }:
{
  fileSystems."/mnt/husky" = lib.mkForce {
    device = "/dev/disk/by-uuid/6890CAB85551B637";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
      "gid=100"
      "noatime"
      "umask=000"
      "nofail"
      "x-gvfs-show"
      "x-systemd.mount-timeout=5"
    ];
  };
}
