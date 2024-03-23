{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { 
    self, 
    nixpkgs, 
    home-manager, 
    ... 
  } @ inputs: let
    inherit (self) outputs;

    user = "koenb";
		system = "x86_64-linux";
  in {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
			inherit system;
      specialArgs = { inherit inputs outputs user; };
      modules = [
        ./hosts
        ./hosts/laptop
      ];
    };
  };
}
