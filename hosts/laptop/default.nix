{ config, pkgs, user, ... }:
{
  imports = [
    ./hardware-configuration.nix 
    ../../modules/desktop/hyprland/default.nix
  ];

  boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      loader = {
          efi = {
              canTouchEfiVariables = true;
              efiSysMountPoint = "/boot";
          };
          grub = {                              
              enable = true;
              theme = pkgs.nixos-grub2-theme;
              devices = [ "nodev" ];
              efiSupport = true;
              useOSProber = true;                
              configurationLimit = 2;
          };
          # timeout = 1;   
      };
  };

  #boot.loader = {
  #  systemd-boot.enable = true;
  #  efi.canTouchEfiVariables = true;
  #};

  programs = {
    dconf.enable = true;
    light.enable = true;
  };
}
