{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      background = "#141415";
      foreground = "#FFE9DD";
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
