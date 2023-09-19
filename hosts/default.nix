{ inputs, hardware, home-manager, hyprland, nixpkgs, user, ... }:
let 
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in {
  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = { 
      inherit hyprland inputs pkgs user; 
      host = {
        hostName = "laptop";
      };
    };
    modules = [
      ./laptop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { 
          inherit pkgs user; 
          host = {
            hostName = "laptop";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./laptop/home.nix)];
        };
      }
    ];
  };
}
