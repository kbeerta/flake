{ 
  inputs, 
  outputs,
  lib, 
  config,
  pkgs,
  user,
  ... 
}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    systemd.enable = true;

    settings = {
      main = {
        layer = "top";
        position = "bottom";
        height = 25;

        modules-left = [
          "sway/workspaces"
        ];

        modules-right = [
          "disk"
          "battery"
          "clock"
        ];

        "sway/workspaces" = {
          format = "*";
          persistent-workspaces = {
            "1" = [ ];   
            "2" = [ ];   
            "3" = [ ];   
            "4" = [ ];   
            "5" = [ ];   
          };
          on-click = "activate";
          tooltip = false;
        };

        "disk" = {
          format = "/ {percentage_used}%";
          interval = 60;
          tooltip = false;
        };
      };
    };

    style = ''
      @import "./theme/catppuccin/themes/mocha.css";

      @define-color bg #111111;

      * {
        all: unset;
        font-family: "JetBrainsMono NF";
        font-size: 12px;
        font-weight: bold;
      }

      span {
        color: @mauve;
      }

      window#waybar {
        color: @text;
        background-color: alpha(@bg, 0.95);
      }

      #workspaces button {
        padding: 1px 8px;
        color: @mauve;
      }

      #workspaces button.focused {
        color: @bg;
        background-color: @mauve;
      }

      #battery,
      #disk {
        padding: 1px 8px;
        color: @bg;
        background-color: @mauve;
      }

      #clock {
        padding: 1px 8px;
      }
    '';
  };

  home.file."waybar/catppuccin" = {
    recursive = true;
    target = ".config/waybar/theme/catppuccin";
    source = (pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "waybar";
      rev = "0830796af6aa64ce8bc7453d42876a628777ac68";
      sha256 = "sha256-9lY+v1CTbpw2lREG/h65mLLw5KuT8OJdEPOb+NNC6Fo=";
    });
  };
}
