{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
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
        x = -1;
	y = 0;
      };
    };
  };
}
