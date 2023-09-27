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
        rev = "4912977";
        sha256 = "sha256-oRyS66vOTaqtsrI04OKDt8b0ri0QKYGAruWV0ub4I1Q=";
      };
    };
  };
}

