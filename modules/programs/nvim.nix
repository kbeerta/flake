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
        rev = "83ce79d";
        sha256 = "sha256-mWGw95aMd57+VczOzg1hU7f8IrUirkZW+Ln/CcPAJXE=";
      };
    };
  };
}
