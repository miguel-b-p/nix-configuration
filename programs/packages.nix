{ pkgs, inputs, ... }:
let
  llm-agents-pkgs = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  environment.systemPackages =
    with pkgs;
    with llm-agents-pkgs;
    [
      # Productivity
      # anytype

      # Browsers
      (vivaldi.override {
        commandLineArgs = "--password-store=basic";
      })
      chromium

      # Development
      micro
      vnote

      # Files
      file-roller

      # Multimedia
      vlc
      loupe
      obs-studio
      obs-studio-plugins.obs-move-transition
      obs-studio-plugins.obs-scene-as-transition

      # Downloads
      motrix
      qbittorrent

      # LLM Agents

      # Local AI
      (pkgs.callPackage ./ollama/package.nix {
        acceleration = "rocm";
        rocmGpuTargets = [ "gfx1032" ]; # RX 6600
        ollama = null;
        ollama-rocm = null;
        ollama-cuda = null;
        ollama-vulkan = null;
        nixosTests = null;
      })
    ];
}
