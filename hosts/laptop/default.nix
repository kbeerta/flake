{ config, pkgs, user, ... }:
{
  imports = [
    ./hardware-configuration.nix 
    ../../modules/desktop/hyprland/default.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  programs = {
    light.enable = true;
  };
}
