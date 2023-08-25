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
        rev = "98b1e46";
        sha256 = "avenpnbcoryNYE7PmZFe9WcUZg0UBFul/gPbF+qN27o=";
      };
    };
  };
}

