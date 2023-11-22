{ pkgs, user, ... }:
{
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
            background = "#111111";
            foreground = "#EEEEEE";
          };
        };
        font = {
          size = 10;
          normal.family = "JetBrainsMono Nerd Font";
          bold = { style = "Bold"; };
        }
      };
    }
  }
}
