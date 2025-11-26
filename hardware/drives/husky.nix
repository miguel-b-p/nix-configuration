{lib, ...}: {
  fileSystems."/mnt/husky" = lib.mkForce {
    device = "/dev/disk/by-uuid/342C28AB71615AB2";
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
