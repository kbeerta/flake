{ config, lib, pkgs, user, ...}:
{
  programs.neovim = {
    enable = true;
  };

  home-manager.users.${user} = {
    home.file.".config/nvim" = {
      recursive = true;
      source = pkgs.fetchFromGitHub {
        owner = "kbeerta";
        repo = "nvim-config";
        rev = "9de419d";
        sha256 = "oPZ35ZCK10BlfUJ4h3cRi9Y3R2eYxTgf3fWM98igsQ4=";
      };
    };
  };
}
