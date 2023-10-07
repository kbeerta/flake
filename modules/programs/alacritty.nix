{ pkgs, var, ... }:
let 
  colors = import ../colors.nix;
in
{
  home-manager.users.${var.user} = {
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
            background = "${colors.primary}";
            foreground = "${colors.text}";
          };
        };
        font = rec {
          size = 11;
          normal.family = "JetBrainsMono Nerd Font";
          bold = { style = "Bold"; };
        };
      };
    };
  };
}
