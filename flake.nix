{
  description = "Personal NixOs system flake";

  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:vaxerski/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, hardware, home-manager, hyprland, ... }: 
  let
    user = "koenb";
    location = "$HOME/.flake";
  in {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
	      inherit inputs hardware home-manager hyprland location nixpkgs user;
      }
    );
  };
}
