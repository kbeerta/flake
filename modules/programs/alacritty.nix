{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
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
