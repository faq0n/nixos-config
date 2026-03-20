{
  description = "A flake for my NixOS configuration - 2026 Edition";

  inputs = {

    # Package Management
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Core Packages
    helix.url = "github:helix-editor/helix/master";
    nix-colors.url = "github:misterio77/nix-colors";

    # User Management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Disk Management
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secret Management
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nur, home-manager, helix, nix-colors, disko, agenix, ... }: let
    secrets = builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
  in {

    nixosConfigurations = {

      manatee = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs secrets; };
        modules = [
          ./hosts/manatee/configuration.nix
          ./modules/common.nix
	  ./modules/git.nix
	  ./modules/server.nix
        ];
      };
    };
  };
}
