#
# Hyprland
#

{ config, hyprland, lib, pkgs, ... }:
{
  imports = [
    ../../programs/eww.nix
  ];

  hardware.opengl.enable = true;

  environment = {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec dbus-launch Hyprland 
      fi
    '';
    variables = {
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_CURRENT_DESKTOP = "Hyprland";
    };
    sessionVariables = {
      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };
    systemPackages = with pkgs; [
        wl-clipboard
        wlr-randr

        grim

        wbg

        xwayland
    ];
  };

  programs = {
    hyprland = {
      enable = true;
      package = hyprland.packages.${pkgs.system}.hyprland;
    };
    dconf.enable = true;
  };

  xdg.portal = {
      enable = true;
      wlr.enable = true;
  };
}
