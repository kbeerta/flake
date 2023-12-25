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
        rev = "49f5de6";
        sha256 = "sha256-A4awkFii146ctPIPz6bJ1u6jrRIDJ1r8kXo7aAZ20nY=";
      };
    };
  };
}
