{ inputs, config, lib, pkgs, user, ... }:
let
  theme = import ../theme.nix;
in with lib; {
  config = mkIf (config.hyprland.enable) {
    environment.systemPackages = with pkgs; [
      libnotify
    ];

    home-manager.users.${user} = {
      services.mako = {
        enable = true;
        defaultTimeout = 5000;

        font = "JetBrainsMono Nerd Font";

        anchor = "bottom-center";
        margin = "20";

        backgroundColor = theme.bg1;
        textColor = theme.fg0;
        progressColor = theme.fg9;

        borderRadius = 5;
        borderSize = 0;
      };
    };
  };
}

