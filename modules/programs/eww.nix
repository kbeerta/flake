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
        rev = "d4c5d68";
        sha256 = "tLBjgifVI8+SZCpOH625WC2vaw072uxKm6cm5UGTzhA=";
      };
    };
  };
}

