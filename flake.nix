{
  description = "Personal NixOs system flake";

  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprland = {
      url = "github:vaxerski/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, ... }: 
  let
    user = "koenb";
    location = "$HOME/.flake";
  in {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
	      inherit home-manager hyprland inputs location nixpkgs nixpkgs-unstable user;
      }
    );
  };
}
