#
# Sway
#

{ config, lib, pkgs, ... }:
{
  imports = [
    ../../programs/eww.nix
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
        wlr-randr

        grim

        swaybg
        swayidle
        swaylock

        xwayland
      ];
    };
  };

  xdg.portal = {
      enable = true;
      wlr.enable = true;
  };
}
