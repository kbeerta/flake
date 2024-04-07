{ 
  inputs,
  outputs,
  config,
  lib,
  options,
  pkgs,
  user,
  ...
}: {
  imports = [
    ./hardware.nix
  ];

	environment = {
    systemPackages = with pkgs; [
      alacritty

      inputs.hyprland.packages.${pkgs.system}.hyprland
    ];
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec dbus-launch ${inputs.hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland
      fi
    '';
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
    hostName = "nixos";
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
