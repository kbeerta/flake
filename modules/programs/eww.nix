{ config, lib, pkgs, var, ... }:
with lib;
{
  config = mkIf (config.wayland.enable) {
    environment.systemPackages = with pkgs; [
      eww-wayland
    ];

    home-manager.users.${var.user} = {
      home.file.".config/eww" = {
        recursive = true;
        source = pkgs.fetchFromGitHub {
          owner = "kbeerta";
          repo = "eww-config";
          rev = "1660e16";
          sha256 = "sha256-jkWBfYWG2eFkM33vUpJ9BuYGl8fYZTXPvEANJcGbKHg=";
        };
      };
    };
  };
}

