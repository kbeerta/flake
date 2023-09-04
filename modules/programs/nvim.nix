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
        rev = "63824ec";
        sha256 = "ZumaUghZ394fkygtCMQgeUz15socMRIoIk1v8F45d3Y=";
      };
    };
  };
}
