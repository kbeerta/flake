{ pkgs, user, ... }:
let
  theme = import ../theme.nix;
in {
  home-manager.users.${user} = {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 2;
            y = 2;
          };
        };
        colors = {
          primary = {
            background = theme.bg0;
            foreground = theme.fg0;
          };
          normal = {
            black = "#000000";
            white = "#FFFFFF";

            red = theme.red;

            # red = theme.fg9;
            blue = theme.fg9;
            cyan = theme.fg9;
            green = theme.fg9;
            yellow = theme.fg9;
            magenta = theme.fg9;
          };
        };
        font = {
          size = 11;
          normal.family = "JetBrainsMono Nerd Font";
          bold = { style = "Bold"; };
        };
        cursor = {
          style = {
            shape = "Underline";
          };
        };
      };
    };
  };
}
