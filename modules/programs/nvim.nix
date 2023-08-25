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
        rev = "6cfeb83";
        sha256 = "ctteORLTSTx4e5Hau5GEl6R+4Mwcwc9I5oEzNFgjjlY=";
      };
    };
  };
}
