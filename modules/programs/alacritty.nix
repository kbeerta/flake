{ pkgs, user, ... }:
{
  home-manager.users.${user} = {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 0.85;
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
          size = 11;
          normal.family = "JetBrainsMono Nerd Font";
          bold = { style = "Bold"; };
        };
      };
    };
  };
}
