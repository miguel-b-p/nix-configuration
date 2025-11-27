{ config, pkgs, ... }:

{

  # velora.gpu = "amd";
  environment.systemPackages = with pkgs; [
    pciutils
  ];
  environment.sessionVariables = {
    MESA_SHADER_CACHE_MAX_SIZE = "12G";
    AMD_VULKAN_ICD = "RADV";
  };

  hardware = {
    enableAllFirmware = true;

    graphics = {
      enable = true;
      enable32Bit = true;
      package = pkgs.mesa_git;
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
