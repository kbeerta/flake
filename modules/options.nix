{ lib, ... }:
with lib;
{
  options = {
    wayland = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enables the wayland configuration
            > Gets enabled when using a wayland wm
        '';
      };
    };
    x11 = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enables the x11 configuration
            > Gets enabled when using a x11 wm
        '';
      };
    };

    gnome = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable gnome within this flake
        '';
      };
    };
    sway = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          Enable sway within this flake
        '';
      };
    };
  };
}
