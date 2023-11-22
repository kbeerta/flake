{ config, lib, pkgs, user, ... }:
with lib; {
  config = mkIf (config.hyprland.enable) {
    home-manager.users.${user} = {
      programs = {
        rofi = {
          enable = true;
          package = pkgs.rofi-wayland;
          location = "center";
          font = "JetBrainsMono Nerd Font";
          # theme = { };
        };
      };
    };
  };
}
