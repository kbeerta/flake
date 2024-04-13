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
    systemd = {
      enable = true;
      target = "sway-session.target";
    };

    settings = {
      main = {
        layer = "top";
        position = "top";
        height = 30;

        margin-top = 10;
        margin-left = 10;
        margin-right = 10;

        modules-left = [
          "sway/workspaces"
          "custom/sep"
        ];

        modules-right = [
          "clock"
          "custom/sep"
          "battery"
        ];

        "sway/workspaces" = {
          format = "";
          all-outputs = true;
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

        "custom/sep" = {
          format = "|";
        };
      };
    };

    style = ''
      @import "./theme/catppuccin/themes/mocha.css";

      @define-color bg #111111;

      * {
        all: unset;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 12px;
        font-weight: bold;
      }

      window#waybar {
        color: @text;
        background-color: alpha(@bg, 0.95);
        border-radius: 5px;
      }

      #workspaces {
        margin: 2px 5px;
      }

      #workspaces button {
        margin: 2px 10px;
        color: @surface1;
      }

      #workspaces button.focused {
        color: @mauve;
      }

      #battery,
      #clock {
        margin: 2px 10px;
      }

      #battery {
        margin-right: 15px;
      }

      #custom-sep {
        margin: 2px 5px;
        color: @surface0;
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
