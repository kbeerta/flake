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
        rev = "c7fbc2e";
        sha256 = "sha256-v4vVJL0s24JhPd73fbqIAZgnma3HtHNYmFbsdPZE0os=";
      };
    };
  };
}
