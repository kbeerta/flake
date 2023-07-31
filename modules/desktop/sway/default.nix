#
# Sway
#

{ config, lib, pkgs, ... }:
{
  imports = [
    ../../programs/waybar.nix
  ];

  hardware.opengl.enable = true;

  environment = {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec sway
      fi
    '';
  };

  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        wl-clipboard

        swaybg
        swayidle
        swaylock

        xwayland
      ];
    };
  };
}
