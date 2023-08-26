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
        rev = "26c2e4e";
        sha256 = "Lh/KNRdwp5yA68DDNuCApAZrHx8uAXNWcsYhqKQbLlQ=";
      };
    };
  };
}

