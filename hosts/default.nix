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
  options = {
    wayland = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enables the wayland configuration
            > Gets enabled when using a wayland wm
        '';
      };
    };
    x11 = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enables the x11 configuration
            > Gets enabled when using a x11 wm
        '';
      };
    };
  };

  laptop = nixosSystem {
    inherit system;
    specialArgs = { 
      inherit inputs unstable var; 
    };
    modules = [
      ./laptop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}
