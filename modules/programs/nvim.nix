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
        rev = "5a14376";
        sha256 = "sha256-BpTvhrIiSrFfHKDfsLlnhYtqb3oXqBFqQAd/X+OqRek=";
      };
    };
  };
}
