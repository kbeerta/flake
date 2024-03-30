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
          x = 5;
          y = 5;
        };
        startup_mode = "Fullscreen";
      };
      colors.primary = {
        background = "#101010";
        foreground = "#FEFEFE";
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
