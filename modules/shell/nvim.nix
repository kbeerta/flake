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
        rev = "db3ca2f";
        sha256 = "sha256-7emV+ruCvWiZx+foyOsxLCNoUZ0wadph+zx/FvT73xA=";
      };
    };
  };
}
