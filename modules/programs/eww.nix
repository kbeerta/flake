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
          rev = "8bb7e7f";
          sha256 = "sha256-BN+q+jSA4kUdwardUsHslpWejQzi4u5af96mMYSo9hw=";
        };
      };
    };
  };
}

