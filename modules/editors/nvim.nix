{ pkgs, var, ... }:
{
  programs.neovim = {
    enable = true;
  };

  home-manager.users.${var.user} = {
    home.file.".config/nvim" = {
      recursive = true;
      source = pkgs.fetchFromGitHub {
        owner = "kbeerta";
        repo = "nvim-config";
        rev = "f86786d";
        sha256 = "sha256-87iZE9vZs/KqTiEI7ZRxORwttZlvDrI3yuWRUOn6+WU=";
      };
    };
  };
}
