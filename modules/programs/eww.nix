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
        rev = "403520f";
        sha256 = "sha256-kK2nweaRLM28abScl80n1hcCq64qbQjGOUzWehSbHUY=";
      };
    };
  };
}

