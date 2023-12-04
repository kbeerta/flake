{
  description = "snowflake";

  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOs-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: 

  let
    user = "koenb";

    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      overlay = [
        inputs.nur.overlay
      ];
      config.allowUnfree = true;
    };

    lib = import ./lib;
  in 

  {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = {
          inherit inputs user;
        };
        modules = [
          ./hosts        # default 'configuration.nix' for all hosts
          ./hosts/laptop # specific 'configuration.nix' for laptop target

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
      wsl = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = {
          inherit inputs user;
        };
        modules = [
          ./hosts     # default 'configuration.nix' for all hosts
          ./hosts/wsl # specific 'configuration.nix' for wsl target

          inputs.nur.nixosModules.nur

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
    };
  };
}

