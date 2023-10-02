{ pkgs, user, ... }:
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
        rev = "19959ac";
        sha256 = "sha256-UGbzIhRnsbaacIpRZNgcvuvtt2mzPfJxKusCXC4TlJU=";
      };
    };
  };
}

