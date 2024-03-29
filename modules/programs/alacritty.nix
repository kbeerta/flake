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
            black = theme.bg0;
            white = theme.fg0;

            red = theme.red;
            blue = theme.special;
            cyan = theme.special;
            green = theme.special;
            yellow = theme.special;
            magenta = theme.special;
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
