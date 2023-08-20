#
# River
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
        exec river 
      fi
    '';
    systemPackages = with pkgs; [
        river

        wl-clipboard
        wlr-randr

        grim

        swaybg

        xwayland
    ];
  };

  programs.dconf.enable = true;

  xdg.portal = {
      enable = true;
      wlr.enable = true;
  };
}
