{ 
  pkgs,
  ...
}: {
  # TODO move into parent folder
  imports = [
    ./hardware.nix
  ];

  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
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
