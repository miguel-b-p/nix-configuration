{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    home-manager = {
      url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:lonerOrz/nyx-loner";
    flox.url = "github:flox/flox/latest";
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    preload-ng = {
      url = "/home/mingas/projetos/preload-ng";
    };
    llm-agents.url = "github:numtide/llm-agents.nix";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
  };

  outputs =
    {
      self,
      nixpkgs,
      chaotic,
      flox,
      home-manager,
      nix-flatpak,
      antigravity-nix,
      preload-ng,
      llm-agents,
      determinate,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        NixOS = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            chaotic.nixosModules.default
            nix-flatpak.nixosModules.nix-flatpak
            preload-ng.nixosModules.default
            determinate.nixosModules.default
            {
              environment.systemPackages = [
                flox.packages.x86_64-linux.default
                antigravity-nix.packages.x86_64-linux.default
              ];
            }
          ];
        };
      };
    };
}
