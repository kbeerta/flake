{ pkgs, user, ... }:
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
        rev = "4df6ba7";
        sha256 = "sha256-ly/RPOAJK2CJdbem/rupyQ61mBUs/7JwWVg3SKqDygY=";
      };
    };
  };
}
