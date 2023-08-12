{ config, pkgs, user, ... }:
{
  imports = [
    ./hardware-configuration.nix 
    ../../modules/desktop/river/default.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  programs = {
    light.enable = true;
  };
}
