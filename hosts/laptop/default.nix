{ pkgs, user, ... }:
{
  imports = [
    ./hardware.nix
  ];

  hyprland.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {                              
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;                
        configurationLimit = 2;
      };
      timeout = 1;   
    };
  };

  environment = {
    systemPackages = with pkgs; [
      discord
      firefox
    ];
  };

  programs = {
    light.enable = true;
  };
}
