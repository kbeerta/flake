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
      import = [ ".config/alacritty/theme/catppuccin-mocha.toml" ];
      window = {
        padding = {
          x = 2;
          y = 2;
        };
      };
      colors.primary = {
        background = "#111111";
        foreground = "#EEEEEE";
      };
      font = {
        size = 11;
        normal.family = "IosevkaTerm Nerd Font";
      };
      mouse.hide_when_typing = true;
    };
  };

  home.file."catppuccin" = {
    target = ".config/alacritty/theme";
    source = (pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "alacritty";
      rev = "94800165c13998b600a9da9d29c330de9f28618e";
      sha256 = "sha256-Pi1Hicv3wPALGgqurdTzXEzJNx7vVh+8B9tlqhRpR2Y=";
    });
  };
}
