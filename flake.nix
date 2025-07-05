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

    users = [
      {
        name = "kbeerta";
        groups = [ "wheel" "input" "networkmanager" ];
        fonts = with pkgs; [nerd-fonts.iosevka];
        packages = with pkgs; [ripgrep fzf tmux alacritty firefox discord];
      }
    ];
  in {
    nixosConfigurations = {
      sputnik = utils.mkHost {
        users = users;
        name = "sputnik";
        config = ./hosts/sputnik;
      };
    };
  };
}
