#
# Eww
#
# Gets imported in Window Manager
#

{ config, lib, pkgs, user, ...}:
{
  environment.systemPackages = with pkgs; [
    eww-wayland
  ];

  home-manager.users.${user} = {
    home.file.".config/eww" = {
      recursive = true;
      source = ./eww;
    };
  };
}

