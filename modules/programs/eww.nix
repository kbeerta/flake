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
          rev = "d128562";
          sha256 = "sha256-OHlc6Yt7l3biREAbndaxADAEhFjHTmDlzfKasgfw1jU=";
        };
      };
    };
  };
}

