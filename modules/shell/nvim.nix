{ pkgs, user, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home-manager.users.${user} = {
    home.file.".config/nvim" = {
      recursive = true;
      source = pkgs.fetchFromGitHub {
        owner = "kbeerta";
        repo = "nvim-config";
        rev = "60c0e70";
        sha256 = "sha256-1CajlrNqGe3FnOZ9C0oj5Rh0uB3GfrSNcT5G25DKMMs=";
      };
    };
  };
}
