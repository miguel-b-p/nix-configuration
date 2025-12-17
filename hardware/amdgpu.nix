{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    pciutils
    radeontop
  ];
  environment.sessionVariables = {
    MESA_SHADER_CACHE_MAX_SIZE = "12G";
    AMD_VULKAN_ICD = "RADV";
    RADV_PERFTEST = "nggc";
    # RADV_FORCE_VRS = "2x2";
  };
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
    "amdgpu.dcdebugmask=0x10"
  ];

  hardware = {
    enableAllFirmware = true;

    graphics = {
      enable = true;
      enable32Bit = true;
      package = pkgs.mesa;
    };

    amdgpu.opencl.enable = true;
    firmware = [ pkgs.linux-firmware ];
  };

  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
          rocm-runtime
          rocm-device-libs
          rocminfo
          rocm-smi
        ];
      };
    in
    [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];
}
