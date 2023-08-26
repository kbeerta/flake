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
        rev = "22609c5";
        sha256 = "jlSsWg/Otk+c2Lr8UgnKSohOVzrpo5U14Xq2U6g6FCc=";
      };
    };
  };
}

