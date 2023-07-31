{
  description = "Personal NixOs system flake";

  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, ... }: 
  let
    user = "koenb";
  in {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
	inherit home-manager inputs nixpkgs nixpkgs-unstable user;
      }
    );
  };
}
