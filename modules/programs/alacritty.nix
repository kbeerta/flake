{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        # opacity = 0.8;
        # offset = {
        #   x = 32;
	      #   y = 32;
        # };
      };
      colors = {
        primary = {
          background = "#111111";
          foreground = "#FCF8ED";
	    };
      };
      font = rec {
        normal.family = "JetBrainsMono Nerd Font";
	      bold = { style = "Bold"; };
      };
    };
  };
}
