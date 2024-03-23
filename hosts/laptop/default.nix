{ pkgs, inputs, user, ... }:
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
      systemd-boot.enable = true;
      timeout = 1;   
    };
  };

  environment = {
    systemPackages = with pkgs; [
      discord
      firefox
    ];
  };

  hardware.bluetooth = {
    enable = true;
    settings = {
      General.Enable = "Source,Sink,Media,Socket";
    };
  };

  programs = {
    light.enable = true;
  };
}
