{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.90;
        padding = {
          x = 2;
	        y = 2;
        };
      };
      colors = {
        primary = {
          background = "#111111";
          foreground = "#EEEEEE";
	      };
      };
      font = rec {
        size = 11;
        normal.family = "JetBrainsMono Nerd Font";
	      bold = { style = "Bold"; };
      };
    };
  };
}
