{ inputs, config, lib, pkgs, user, ... }:
with lib; {
  config = mkIf (config.hyprland.enable) {
    services.upower.enable = true;
    home-manager.users.${user} = {
      imports = [
        inputs.ags.homeManagerModules.default
      ];

      programs.ags = {
        enable = true;
        extraPackages = [ pkgs.libsoup_3 ];
      };
    };
  };
}

