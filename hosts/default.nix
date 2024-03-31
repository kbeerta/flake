{ home-manager, inputs, lib, outputs, pkgs, user, ... }: {
	users = {
    defaultUserShell = pkgs.zsh;
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "audio" "networkmanager" "wheel" "video" ];
    };
  };

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  
  environment = {
    etc = {
      "nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
    };
  };

  programs = {
    git.enable = true;
#    neovim = {
#      enable = true;
#      defaultEditor = true;
#    };
    zsh.enable = true;
  };

  nixpkgs = {
    # overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };

  nix = {
    # channel.enable = false;
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
    };
  };

  system.stateVersion = "24.05";
}

