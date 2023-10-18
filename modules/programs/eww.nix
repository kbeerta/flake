{ config, lib, pkgs, var, ... }:
with lib;
{
  config = mkIf (config.wayland.enable) {
    environment.systemPackages = with pkgs; [
      eww-wayland

      # utility i use to get sway workspace id
      jq
    ];

    home-manager.users.${var.user} = {
      home.file.".config/eww" = {
        recursive = true;
        source = pkgs.fetchFromGitHub {
          owner = "kbeerta";
          repo = "eww-config";
          rev = "b1c44ae";
          sha256 = "sha256-p6q4jRC460JWe+o6VN3xL48g3oVTfdHFlULdPb9SFIw=";
        };
      };
    };
  };
}

