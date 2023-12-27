{ pkgs, user, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  environment.systemPackages = with pkgs; [
    tree-sitter
  ];

  home-manager.users.${user} = {
    home.file.".config/nvim" = {
      recursive = true;
      source = pkgs.fetchFromGitHub {
        owner = "kbeerta";
        repo = "nvim-config";
        rev = "f3d274c";
        sha256 = "sha256-RebbLgueWSuCDYjXKbs+LjG6PkU4aRVW95oeKJqlIPQ=";
      };
    };
  };
}
