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
        rev = "4365e7a";
        sha256 = "Jjyg8wGmKCI+REanNOid7RNB2/ZKj2VDCB9waBXqdlA=";
      };
    };
  };
}
