{
  description = "Flake";

  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: 

  let
    user = "koenb";

    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      overlay = [];
      config.allowUnfree = true;
    };
  in 

  {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = {
          inherit inputs user;
        };
        modules = [
          inputs.nixvim.nixosModules.nixvim

          ./hosts        # default 'configuration.nix' for all hosts
          ./hosts/laptop # specific 'configuration.nix' for laptop target

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
    };
  };
}

