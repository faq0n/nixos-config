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

    # Hardware Enablement
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-crostini = { 
      url = "github:aldur/nixos-crostini";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-aarch64-widevine.url = "github:epetousis/nixos-aarch64-widevine";
    i915-sriov = { 
       url = "github:strongtz/i915-sriov-dkms";
       inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nixos-crostini, nur, home-manager, helix, nix-colors, disko, agenix, ... }: let
    # simple secrets passthru
    secrets = builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
    # Helper function to reduce boilerplate for each host
    mkSystem = { hostname, system, modules ? [] }: nixpkgs.lib.nixosSystem {
        inherit system;
        # Pass flake inputs into the module system
        specialArgs = { inherit inputs hostname secrets; };
        modules = [
          # Shared modules for every system
          ./modules/common
          
          # Specific host configuration
          ./hosts/${hostname}

          # Standard flake modules
          home-manager.nixosModules.home-manager
          disko.nixosModules.disko
          agenix.nixosModules.default

          {
            networking.hostName = hostname;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ] ++ modules;
      };
    in {
    nixosConfigurations = {
      # manatee 
      manatee = mkSystem {
        hostname = "manatee";
	system = "x86_64-linux";
        modules = [
          #./hosts/manatee/configuration.nix // taken in helper function
	  ./modules/server
        ];
      };
      # chromebook vm
      wolverine = mkSystem {
        hostname = "wolverine";
        system = "aarch64-linux";
	modules = [
	  #./hosts/wolverine/default.nix
	  nixos-crostini.nixosModules.baguette
        ];
      };

      # Example ARM Server
      arm-server = mkSystem {
        hostname = "arm-server";
        system = "aarch64-linux";
      };

      # Example Host (x86)
      mynixos = mkSystem {
        hostname = "mynixos";
        system = "x86_64-linux";
      }; # end of my-nixos
    }; # end of nixosConfigurations
  }; # end of outputs
}
