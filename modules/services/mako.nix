{ inputs, config, lib, pkgs, user, ... }:
let
  theme = import ../colors.nix;
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

        anchor = "top-right";
        margin = "20";

        backgroundColor = theme.bg1;
        textColor = theme.fg0;
        progressColor = theme.accent;

        borderRadius = 5;
        borderSize = 0;
      };
    };
  };
}

