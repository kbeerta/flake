{ pkgs, user, ... }:
let
  theme = import ../colors.nix;
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
