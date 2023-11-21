{ lib, ... }:
with lib; {
  options = {
    x11 = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
    wayland = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
}
