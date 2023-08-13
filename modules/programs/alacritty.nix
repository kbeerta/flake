{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.8;
      colors = {
        primary = {
          background = "#111111";
          foreground = "#F6F4F4";
	    };
      };
      font = rec {
        normal.family = "JetBrainsMono Nerd Font";
	    bold = { style = "Bold"; };
      };
      offset = {
        x = 0;
	    y = 0;
      };
    };
  };
}
