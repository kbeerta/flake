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

    user = {
      name = "kbeerta";
      groups = [ "wheel" "input" "networkmanager" ];
      packages = with pkgs; [fzf tmux alacritty firefox];
    };
  in {
    nixosConfigurations = {
      mir = utils.mkHost {
        name = "mir";
        config = ./hosts/mir;
        users = [user];
      };
      sputnik = utils.mkHost {
        name = "sputnik";
        config = ./hosts/sputnik;
        users = [user];
      };
    };
  };
}
