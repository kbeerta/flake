{ inputs, home-manager, nixpkgs, nixpkgs-unstable, var, ... }:
let 
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in 
with lib;
{
  laptop = nixosSystem {
    inherit system;
    specialArgs = { 
      inherit inputs unstable var; 
    };
    modules = [
      ./laptop
      ./configuration.nix

      # TODO: find a nicer way to put this in configuration.nix
      ../modules/options.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}
