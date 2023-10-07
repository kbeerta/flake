{
  description = "Personal NixOs system flake";

  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, ... }: 
  let
    var = rec {
      user = "koenb";
      location = "$HOME/.flake";
      terminal = "alacritty";
      editor = "nvim";
      wallpaper = "${location}/wallpapers/landscape.png";
    };
  in {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
	      inherit inputs nixpkgs nixpkgs-unstable home-manager var;
      }
    );
  };
}
