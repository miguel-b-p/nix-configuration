{
  description = "Chaotic-Nyx";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    home-manager = {
      url = "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    flox.url = "github:flox/flox/latest";
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      stylix,
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
            {
              environment.systemPackages = [
                antigravity-nix.packages.x86_64-linux.default
              ];
            }
          ];
        };
      };
    };

  nixConfig = {
    extra-substituters = [
      "https://nixpkgs.cachix.org"
      "https://chaotic-nyx.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
    ];
  };
}
