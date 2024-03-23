{ inputs, outputs, config, lib, options, pkgs, ... }: let
  hostName = "LaptopKB";
in {
  imports = [
    ./hardware.nix
  ];

	environment = {
		loginShellInit = ''
			if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
				exec dwl
			fi
		'';
		variables = {
			EDITOR = "${pkgs.neovim}/bin/nvim";
		};
		systemPackages = with pkgs; [
      git
      neovim
    ];
	};

	fonts.packages = with pkgs; [
		(nerdfonts.override {
			fonts = [ "JetBrainsMono" ];
		})
	];

  hardware = {
    bluetooth.enable = true;
    opengl.enable = true;
  };

  networking = {
    hostName = hostName;
    networkmanager.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot.enable = true;
      timeout = 1;   
    };
  };
}
