{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... } @ inputs: let

    inherit (nixpkgs) lib;

    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];
      config.allowUnfree = true;
    };

    utils = import ./lib {
      inherit pkgs lib system;
    };

    users = [
      {
        name = "kbeerta";
        groups = [ "wheel" "input" "networkmanager" ];
        fonts = with pkgs; [
          nerd-fonts.iosevka
        ];
        packages = with pkgs; [
          # cli
          fzf 
          tmux 
          ripgrep 
          # programs
          alacritty 
          firefox 
          discord
          # shell
          quickshell
        ];
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
