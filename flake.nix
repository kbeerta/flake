{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # TODO add my own overlay for nightly overlays
    nvim = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swayfx = {
      url = "github:WillPower3309/swayfx";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self, 
    nixpkgs, 
    ... 
  } @ inputs: let
    inherit (self) outputs;

    user = "koenb";
		system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        inputs.nvim.overlays.default
        inputs.swayfx.overlays.default
      ];
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
			inherit system pkgs;
      specialArgs = { inherit inputs outputs user; };
      modules = [
        ./hosts
        ./hosts/laptop
      ];
    };
  };
}
