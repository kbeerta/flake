#
# River
#

{ config, lib, pkgs, ... }:
{
  imports = [
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
        wev

        wl-clipboard
        wlr-randr
        xwayland
    ];
  };

  programs.dconf.enable = true;

  xdg.portal = {
      enable = true;
      wlr.enable = true;
  };
}
