{ 
  inputs, 
  outputs,
  lib, 
  config,
  pkgs,
  user,
  ... 
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      # TODO unhardcode alacritty theme location
      import = [ ".config/alacritty/theme/catppuccin/catppuccin-mocha.toml" ];
      window.padding = {
        x = 2;
        y = 2;
      };
      colors.primary = {
        background = "#111111";
      };
      font = {
        size = 11;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
      };
    };
  };

  home.file."alacritty/catppuccin" = {
    recursive = true;
    target = ".config/alacritty/theme/catppuccin";
    source = (pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "alacritty";
      rev = "94800165c13998b600a9da9d29c330de9f28618e";
      sha256 = "sha256-Pi1Hicv3wPALGgqurdTzXEzJNx7vVh+8B9tlqhRpR2Y=";
    });
  };
}
