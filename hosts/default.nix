{ 
  inputs,
  lib,
  pkgs,
  user,
  ...
}: {
	users = {
    defaultUserShell = pkgs.zsh;
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "audio" "networkmanager" "wheel" "video" ];
    };
  };
  
  environment = {
    systemPackages = with pkgs; [
      # programs
      alacritty

      # rice
			autotiling
      pure-prompt

      # util
      fzf

      # gnom
      dwarf-fortress
    ];
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec ${pkgs.swayfx}/bin/sway
      fi
    '';
    etc = {
      "nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
    };
  };

  programs = {
    git = {
      enable = true;
    };
    firefox = {
      enable = true;
    };
    light = {
      enable = true;
    };
    neovim = {
      enable = true;
      package = pkgs.neovim;
    };
    sway = {
      enable = true;
      package = pkgs.swayfx;
      xwayland.enable = true;
    };
		waybar = {
			enable = true;
		};
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      promptInit = ''
        autoload -U promptinit; promptinit 
        zstyle :prompt:pure:path color magenta
        prompt pure
      '';
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

	fonts.packages = with pkgs; [
		(nerdfonts.override {
			fonts = [ 
        "JetBrainsMono" 
      ];
		})
	];

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
    };
  };

  system = {
		activationScripts.config = ''
			ln -Tsf /home/${user}/flake/home /home/${user}/.config	
		'';
		stateVersion = "24.05";
	};
}

