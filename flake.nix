{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swayfx = {
      url = "github:WillPower3309/swayfx";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        inputs.swayfx.overlays.default
      ];
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
			inherit system;
      specialArgs = { inherit inputs outputs user; };
      modules = [
        ./hosts
        ./hosts/laptop
      ];
    };
    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs outputs user; };
      modules = [
        ./home
        # ./home/laptop
      ];
    };
  };
}
