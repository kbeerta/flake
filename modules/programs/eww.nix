{ config, lib, pkgs, user, ... }:
with lib; {
  config = mkIf (config.wayland.enable) {
    environment.systemPackages = with pkgs; [
      eww-wayland
    ];

    home-manager.users.${user} = {
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

