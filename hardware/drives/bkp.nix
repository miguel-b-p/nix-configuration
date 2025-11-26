{lib, ...}: {
  fileSystems."/mnt/bkp" = lib.mkForce {
    device = "/dev/disk/by-uuid/F2B071CCB0719835";
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
