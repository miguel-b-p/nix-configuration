{
  config,
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.overlays = [
    inputs.nix-gaming-edge.overlays.default
    #nix-gaming-edge.overlays.mesa-git
    #nix-gaming-edge.overlays.proton-cachyos
    #nix-gaming-edge.overlays.vintagestory
    #etc.
  ];
  environment.systemPackages = with pkgs; [
    pciutils
    radeontop
    rocmPackages.rocm-cmake
    rocmPackages.hipcc
    rocmPackages.rocm-smi
  ];

  environment.sessionVariables = {
    MESA_SHADER_CACHE_MAX_SIZE = "12G";
    AMD_VULKAN_ICD = "RADV";
    RADV_PERFTEST = "nggc";
    # RADV_FORCE_VRS = "2x2";

    ROCM_PATH = "/opt/rocm";
    HIP_PATH = "/opt/rocm";
    HIP_CLANG_PATH = "/opt/rocm/llvm/bin";
    HSA_OVERRIDE_GFX_VERSION = "10.3.0";
  };

  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
    "amdgpu.dcdebugmask=0x10"
  ];

  drivers.mesa-git = {
    enable = true;
    cacheCleanup = {
      # protonPackage is null by default - thus Proton caches are not cleaned by default. Must define a protonPackage to clear Proton / engine caches
      enable = true;
      protonPackage = pkgs.proton-cachyos; # or variation

      mesaCacheDirs = [
        # optional - default lists pre-configured
        "mesa_shader_cache*"
        "radv_builtin_shaders*"
        #etc.
      ];

      protonCacheFiles = [
        # optional - default lists pre-configured
        "vkd3d-proton.cache*"
        "shader*.cache"
        #etc.
      ];

      protonCacheDirs = [
        # optional - default lists pre-configured
        "*ShaderCache*"
        "D3DSCache*"
        #etc.
      ];
    };
    steamOrphanCleanup = {
      enable = true;
      protectedFolders = [
        # folders to not treat as orphans for deletion ( optional, pre-configured with smart defaults )
        "Proton*"
        "Steam Controller Configs"
        #etc.
      ];
    };
  };

  hardware = {
    enableAllFirmware = true;

    graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [
        # vaapiVdpau
        # libvdpau-va-gl
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        libva
      ];
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
          llvm.llvm
        ];
      };
    in
    [
      "L+ /opt/rocm - - - - ${rocmEnv}"
    ];
}
