{ pkgs, ... }: {
  # ========================================
  # Boot Configuration
  # ========================================
  
  boot = {
    # Filesystems support
    supportedFilesystems = ["ntfs" "exfat" "ext4" "fat32" "btrfs"];
    
    # Clean /tmp on boot
    tmp.cleanOnBoot = true;
    
    # Bootloader configuration
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      timeout = null; # Display bootloader indefinitely
      limine.enable = true;
    };
  };
}
