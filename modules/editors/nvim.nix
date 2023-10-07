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
        rev = "dacf0ee";
        sha256 = "sha256-gknWHK1jDpGCZrTmqDKRe7iAD1ZBk8zN3m64rXFVMt0=";
      };
    };
  };
}
