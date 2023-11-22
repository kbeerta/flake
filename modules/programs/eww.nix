{ config, lib, pkgs, user, ... }:
with lib; {
  config = mkIf (config.hyprland.enable) {
    environment.systemPackages = with pkgs; [
      eww-wayland
    ];

    home-manager.users.${user} = {
      home.file.".config/eww" = {
        recursive = true;
        source = pkgs.fetchFromGitHub {
          owner = "kbeerta";
          repo = "eww-config";
          rev = "ae5bb2e";
          sha256 = "sha256-xoZk2rF+9+aY6nH0Or1Mk6WW722jVv/++B8cf+ac12w=";
        };
      };
    };
  };
}

