{ config, lib, pkgs, user, ...}:
{
  environment.systemPackages = with pkgs; [
    eww-wayland
  ];

  home-manager.users.${user} = {
    home.file.".config/eww" = {
      recursive = true;
      source = pkgs.fetchFromGitHub {
        owner = "kbeerta";
        repo = "eww-config";
        rev = "f81d507";
        sha256 = "ISqRzj2E6/iT6N7EYs24ZiYrz6z/87//pp4YOR5zUJ0=";
      };
    };
  };
}

