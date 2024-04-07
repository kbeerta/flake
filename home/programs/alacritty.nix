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
      window = {
        padding = {
          x = 2;
          y = 2;
        };
      };
      colors.primary = {
        background = "#000000";
        foreground = "#FFFFFF";
      };
      font = {
        size = 11;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
      };
      mouse.hide_when_typing = true;
    };
  };
}
