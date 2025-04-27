{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    inherit (nixpkgs) lib;

    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      overlays = [];
      config.allowUnfree = true;
    };

    utils = import ./lib {
      inherit pkgs lib system;
    };

    kbeerta = {
      name = "kbeerta";
      shell = pkgs.bash;
      groups = [ "wheel" "networkmanager" ];
      packages = with pkgs; [stow tmux];
    };
  in {
    nixosConfigurations = {
      sputnik = utils.mkHost {
        name = "sputnik";
        config = ./hosts/sputnik;
        users = [kbeerta];
      };
    };
  };
}
