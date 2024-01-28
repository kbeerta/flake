{ config, lib, pkgs, user, ... }:
let 
  inherit (config.home-manager.users.${user}.lib.formats.rasi) mkLiteral;
  theme = import ../colors.nix;
in with lib; {
  config = mkIf (config.hyprland.enable) {
    home-manager.users.${user} = {
      programs = {
        rofi = {
          enable = true;
          package = pkgs.rofi-wayland;
          theme = {
            "*" = {
              font = "JetBrainsMono Nerd Font 12";

              bg0 = mkLiteral "${theme.bg0}E6";
              accent = mkLiteral "${theme.fg9}E6";

              fg0 = mkLiteral "${theme.fg0}";
              fg1 = mkLiteral "${theme.fg0}80";

              background-color = mkLiteral "transparent";
              text-color = mkLiteral "@fg0";

              margin = 0;
              padding = 0;
              spacing = 0;
            };

            "window" = {
              background-color = mkLiteral "@bg0";

              location = mkLiteral "center";
              border-radius = mkLiteral "5px";
              width = 640;
            };

            "inputbar" = {
              font = "JetBrainsMono Nerd Font 20";

              padding = mkLiteral "12px";
              spacing = mkLiteral "12px";
              children = mkLiteral "[ entry ]";
            };

            # "icon-search" = {
            #   expand = false;
            #   filename = "search";
            #   size = mkLiteral "28px";
            # };

            "icon-search, entry, element-icon, element-text" = {
              vertical-align = mkLiteral "0.5";
            };

            "entry" = {
              font = mkLiteral "inherit";
              placeholder = "Search";
              placeholder-color = mkLiteral "@fg1";
            };

            "message" = {
              border = mkLiteral "2px 0 0";
              border-color = mkLiteral "@bg0";
              background-color = mkLiteral "@bg0";
            };

            "textbox" = {
              padding = mkLiteral "8px 24px";
            };

            "listview" = {
              lines = 10;
              columns = 1;
              fixed-height = false;
              border = mkLiteral "1px 0 0";
              border-color = mkLiteral "@bg0";
            };

            "element" = {
              padding = mkLiteral "8px 16px";
              spacing = mkLiteral "16px";
              background-color = mkLiteral "transparent";
            };

            "element normal active" = {
              text-color = mkLiteral "@accent";
            };

            "element selected normal, element selected active" = {
              background-color = mkLiteral "@accent";
              text-color = mkLiteral "@bg0";
            };

            "element-icon" = {
              size = mkLiteral "1em";
            };

            "element-text" = {
              text-color = mkLiteral "inherit";
            };
          };
        };
      };
    };
  };
}
