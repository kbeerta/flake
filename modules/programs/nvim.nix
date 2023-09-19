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
        rev = "336dbc4";
        sha256 = "sha256-LdZoSq6W9EmsyUWUMLlCZCC4om7v/9foTHRum1j2oIU=";
      };
    };
  };
}
